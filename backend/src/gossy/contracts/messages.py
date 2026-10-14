"""Typed MQTT payloads (JSON, camelCase on the wire).

Every data field is traceable to a requirement document or to Phase 0; see docs/mqtt-contract.md.
Validation is strict (no type coercion). The envelope rejects unknown keys; ``data`` ignores
unknown keys so that devices can add fields in a backwards-compatible minor revision.
"""

from __future__ import annotations

from typing import Annotated, Generic, Literal, TypeVar

from pydantic import AfterValidator, AwareDatetime, BaseModel, ConfigDict, Field
from pydantic.alias_generators import to_camel

from gossy.contracts.topics import DEVICE_ID_PATTERN, RESERVED_SERVICE_PREFIX, MessageKind
from gossy.ids import ULID_PATTERN

Percent = Annotated[float, Field(ge=0, le=100)]
UnitInterval = Annotated[float, Field(ge=0, le=1)]
Ulid = Annotated[str, Field(pattern=ULID_PATTERN)]


def _not_service_account(value: str) -> str:
    if value.startswith(RESERVED_SERVICE_PREFIX):
        raise ValueError("deviceId uses the reserved service-account prefix")
    return value


DeviceId = Annotated[str, Field(pattern=DEVICE_ID_PATTERN), AfterValidator(_not_service_account)]


class _Data(BaseModel):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True, strict=True, extra="ignore", frozen=True)


class TelemetryData(_Data):
    # Paper §III.B: "battery levels" are logged and shown in the app.
    battery_pct: Percent
    # Paper §V.A: moisture module (DHT11/DHT22) reports %RH. Agronomic meaning is U-1 (unresolved);
    # the backend stores the reading only and makes no harvesting decision.
    moisture_rh_pct: Percent | None = None
    # PPT module 5: temperature sensor. Range = DHT22 operating range.
    air_temp_c: Annotated[float, Field(ge=-40, le=85)] | None = None
    # Paper §III.B: "harvested boll counts".
    bolls_harvested_total: Annotated[int, Field(ge=0)] | None = None
    # PPT module 6 (power monitoring) and existing dashboard "Solar Active" indicator.
    solar_active: bool | None = None


class PestEventData(_Data):
    # Paper §III.B: detections carry class name, confidence and bounding box.
    label: Annotated[str, Field(min_length=1, max_length=64, pattern=r"^[a-z0-9][a-z0-9_-]*$")]
    confidence: UnitInterval
    # Normalised [x, y, width, height] in the camera frame.
    bbox: tuple[UnitInterval, UnitInterval, UnitInterval, UnitInterval] | None = None


class SprayEventData(_Data):
    # PPT module 4: short controlled bursts; the event is logged. The upper bound is a sanity
    # limit for validation only — burst limits are enforced by device firmware, not the backend.
    duration_ms: Annotated[int, Field(ge=1, le=60_000)]
    # Links the spray to the pest detection that triggered it (PPT module 4 "log the event").
    related_msg_id: Ulid | None = None


class HarvestEventData(_Data):
    # PPT: bolls classified Mature / Immature / Partial.
    maturity: Literal["mature", "immature", "partial"]
    picked: bool
    moisture_rh_pct: Percent | None = None


class StatusData(_Data):
    # Phase 0: retained status; the broker publishes "offline" as the device's Last Will.
    state: Literal["online", "offline"]


DataT = TypeVar("DataT", bound=_Data)


class Envelope(BaseModel, Generic[DataT]):
    model_config = ConfigDict(alias_generator=to_camel, populate_by_name=True, strict=True, extra="forbid", frozen=True)

    schema_id: str = Field(alias="schema", min_length=1, max_length=64)
    msg_id: Ulid
    device_id: DeviceId
    seq: Annotated[int, Field(ge=0, le=2**63 - 1)]
    ts: AwareDatetime
    data: DataT


DATA_MODELS: dict[MessageKind, type[_Data]] = {
    MessageKind.TELEMETRY: TelemetryData,
    MessageKind.PEST: PestEventData,
    MessageKind.SPRAY: SprayEventData,
    MessageKind.HARVEST: HarvestEventData,
    MessageKind.STATUS: StatusData,
}

SCHEMA_IDS: dict[MessageKind, str] = {
    MessageKind.TELEMETRY: "bollbot.telemetry/1",
    MessageKind.PEST: "bollbot.event.pest/1",
    MessageKind.SPRAY: "bollbot.event.spray/1",
    MessageKind.HARVEST: "bollbot.event.harvest/1",
    MessageKind.STATUS: "bollbot.status/1",
}

ENVELOPE_MODELS: dict[MessageKind, type[Envelope]] = {kind: Envelope[model] for kind, model in DATA_MODELS.items()}
