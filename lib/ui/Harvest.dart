import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dashboard.dart'; // <-- Import your Dashboard page

class Harvest extends StatelessWidget {
  const Harvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          },
        ),
        title: const Text(
          'Harvest Logs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ChartCard(title: 'Daily Yield', chart: _DailyYieldChart()),
            const SizedBox(height: 16),
            _ChartCard(title: 'Weekly Yield', chart: _WeeklyYieldChart()),
            const SizedBox(height: 16),
            _ChartCard(title: 'Monthly Yield', chart: _MonthlyYieldChart()),
            const SizedBox(height: 24),
            const Text(
              'Log Entries',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ..._mockLogs.map((log) => _LogEntryCard(log: log)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5FA62C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                    child: const Text('Export Logs'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Color(0xFFE5E5E5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                    child: const Text('Share Logs'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF5FA62C),
        unselectedItemColor: Colors.black38,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          }
          // Add navigation for other tabs if needed
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), // Match Dashboard.dart icon
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Logs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report_outlined),
            label: 'Pests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget chart;
  const _ChartCard({required this.title, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFFF9F9F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                )),
            const SizedBox(height: 8),
            SizedBox(height: 120, child: chart),
          ],
        ),
      ),
    );
  }
}

class _DailyYieldChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('0k');
                if (value == 0.045) return const Text('0.045k');
                if (value == 0.09) return const Text('0.09k');
                if (value == 0.135) return const Text('0.135k');
                return const SizedBox.shrink();
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value >= 0 && value < days.length) {
                  return Text(days[value.toInt()]);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: 0.15,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 0.09),
              FlSpot(1, 0.11),
              FlSpot(2, 0.10),
              FlSpot(3, 0.12),
              FlSpot(4, 0.13),
              FlSpot(5, 0.14),
              FlSpot(6, 0.13),
            ],
            isCurved: true,
            color: const Color(0xFF5FA62C),
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF5FA62C).withOpacity(0.3),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

class _WeeklyYieldChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('0k');
                if (value == 0.25) return const Text('0.25k');
                if (value == 0.5) return const Text('0.5k');
                if (value == 0.75) return const Text('0.75k');
                if (value == 1) return const Text('1k');
                return const SizedBox.shrink();
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const weeks = ['Wk 1', 'Wk 2', 'Wk 3', 'Wk 4'];
                if (value >= 0 && value < weeks.length) {
                  return Text(weeks[value.toInt()]);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: 1,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 0.8),
              FlSpot(1, 0.9),
              FlSpot(2, 0.7),
              FlSpot(3, 0.85),
            ],
            isCurved: true,
            color: const Color(0xFF00B2FF),
            barWidth: 2,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

class _MonthlyYieldChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('0k');
                if (value == 0.95) return const Text('0.95k');
                if (value == 1.9) return const Text('1.9k');
                if (value == 2.85) return const Text('2.85k');
                if (value == 3.8) return const Text('3.8k');
                return const SizedBox.shrink();
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr'];
                if (value >= 0 && value < months.length) {
                  return Text(months[value.toInt()]);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: 4,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3.2),
              FlSpot(1, 2.9),
              FlSpot(2, 3.4),
              FlSpot(3, 3.8),
            ],
            isCurved: true,
            color: const Color(0xFF6E7A89),
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF6E7A89).withOpacity(0.2),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

class _LogEntry {
  final String date;
  final String status;
  final int bales;
  final String description;

  _LogEntry({
    required this.date,
    required this.status,
    required this.bales,
    required this.description,
  });
}

final List<_LogEntry> _mockLogs = [
  _LogEntry(
    date: '2024-07-28',
    status: 'Processed',
    bales: 120,
    description: 'High-quality cotton, no pests detected. Ready for shipment.',
  ),
  _LogEntry(
    date: '2024-07-27',
    status: 'Pending',
    bales: 115,
    description: 'Yield slightly below average. Awaiting quality inspection.',
  ),
  _LogEntry(
    date: '2024-07-26',
    status: 'Rejected',
    bales: 105,
    description:
        'Partial contamination detected, requires further processing. Lower yield due to unexpected rain.',
  ),
  _LogEntry(
    date: '2024-07-25',
    status: 'Processed',
    bales: 130,
    description:
        'Excellent harvest conditions. Optimal moisture levels maintained.',
  ),
  _LogEntry(
    date: '2024-07-24',
    status: 'Processed',
    bales: 110,
    description: 'Standard yield, good quality.',
  ),
  _LogEntry(
    date: '2024-07-23',
    status: 'Pending',
    bales: 98,
    description:
        'Lower yield due to late season pest activity. Inspection needed.',
  ),
];

class _LogEntryCard extends StatelessWidget {
  final _LogEntry log;
  const _LogEntryCard({required this.log});

  Color? getStatusColor(String status) {
    switch (status) {
      case 'Processed':
        return Colors.grey[200];
      case 'Pending':
        return const Color(0xFF00B2FF);
      case 'Rejected':
        return const Color(0xFFFF4D4F);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(log.status);
    final showStatusLabel = log.status != 'Processed';
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  log.date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                if (showStatusLabel)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor!.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      log.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  )
                else
                  Text(
                    log.status,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${log.bales} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const Text(
                  'bales',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              log.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}