import json

import pytest
from pydantic import ValidationError

from gossy.contracts.messages import ENVELOPE_MODELS, SCHEMA_IDS
from gossy.contracts.topics import MessageKind
from tests.conftest import as_bytes, envelope

VALID_DATA = {
    MessageKind.TELEMETRY: {"batteryPct": 87.5, "moistureRhPct": 41.2, "airTempC": 31.0, "bollsHarvestedTotal": 12, "solarActive": True},
    MessageKind.PEST: {"label": "bollworm", "confidence": 0.91, "bbox": [0.1, 0.2, 0.1, 0.1]},
    MessageKind.SPRAY: {"durationMs": 1500},
    MessageKind.HARVEST: {"maturity": "mature", "picked": True},
    MessageKind.STATUS: {"state": "online"},
}


def validate(kind, env):
    return ENVELOPE_MODELS[kind].model_validate_json(as_bytes(env))


@pytest.mark.parametrize("kind", list(MessageKind))
def test_valid_message_per_kind(kind):
    parsed = validate(kind, envelope(SCHEMA_IDS[kind], "sim-0001", VALID_DATA[kind]))
    assert parsed.device_id == "sim-0001"
    assert parsed.ts.tzinfo is not None


def test_telemetry_minimal_only_battery_required():
    parsed = validate(MessageKind.TELEMETRY, envelope(SCHEMA_IDS[MessageKind.TELEMETRY], "sim-0001", {"batteryPct": 50}))
    assert parsed.data.battery_pct == 50 and parsed.data.moisture_rh_pct is None


def test_envelope_rejects_unknown_keys():
    env = envelope(SCHEMA_IDS[MessageKind.STATUS], "sim-0001", {"state": "online"}, command="reboot")
    with pytest.raises(ValidationError):
        validate(MessageKind.STATUS, env)


def test_data_ignores_unknown_keys_for_forward_compatibility():
    data = {**VALID_DATA[MessageKind.STATUS], "firmware": "1.2.3"}
    assert validate(MessageKind.STATUS, envelope(SCHEMA_IDS[MessageKind.STATUS], "sim-0001", data)).data.state == "online"


@pytest.mark.parametrize(
    "kind,data",
    [
        (MessageKind.TELEMETRY, {"batteryPct": "87"}),  # strict: no string -> number coercion
        (MessageKind.TELEMETRY, {"batteryPct": 101}),
        (MessageKind.TELEMETRY, {"batteryPct": 50, "airTempC": 120}),
        (MessageKind.TELEMETRY, {}),
        (MessageKind.PEST, {"label": "Bollworm!", "confidence": 0.5}),
        (MessageKind.PEST, {"label": "bollworm", "confidence": 1.5}),
        (MessageKind.PEST, {"label": "bollworm", "confidence": 0.5, "bbox": [0.1, 0.2, 1.3, 0.1]}),
        (MessageKind.PEST, {"label": "bollworm", "confidence": 0.5, "bbox": [0.1, 0.2]}),
        (MessageKind.SPRAY, {"durationMs": 0}),
        (MessageKind.SPRAY, {"durationMs": 1000, "relatedMsgId": "not-a-ulid"}),
        (MessageKind.HARVEST, {"maturity": "ripe", "picked": True}),
        (MessageKind.STATUS, {"state": "rebooting"}),
    ],
)
def test_invalid_data_rejected(kind, data):
    with pytest.raises(ValidationError):
        validate(kind, envelope(SCHEMA_IDS[kind], "sim-0001", data))


@pytest.mark.parametrize(
    "override",
    [
        {"ts": "2026-09-29T12:00:00"},  # naive timestamp
        {"seq": -1},
        {"seq": "1"},
        {"msgId": "abc"},
        {"deviceId": "svc-ingest"},
    ],
)
def test_invalid_envelope_rejected(override):
    env = envelope(SCHEMA_IDS[MessageKind.STATUS], "sim-0001", {"state": "online"}, **override)
    with pytest.raises(ValidationError):
        validate(MessageKind.STATUS, env)


def test_wire_format_is_camel_case():
    parsed = validate(MessageKind.TELEMETRY, envelope(SCHEMA_IDS[MessageKind.TELEMETRY], "sim-0001", VALID_DATA[MessageKind.TELEMETRY]))
    dumped = json.loads(parsed.model_dump_json(by_alias=True))
    assert set(dumped) == {"schema", "msgId", "deviceId", "seq", "ts", "data"}
    assert "batteryPct" in dumped["data"]
