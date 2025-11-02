import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dashboard.dart';
import 'Harvest.dart';
import 'pest_alerts_page.dart';
import 'notifications_page.dart';
import 'settings_profile_page.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final TextEditingController cottonBollsController =
      TextEditingController(text: '1200');
  final TextEditingController cottonLintController =
      TextEditingController(text: '50');
  final TextEditingController cottonSeedsController =
      TextEditingController(text: '300');

  @override
  void dispose() {
    cottonBollsController.dispose();
    cottonLintController.dispose();
    cottonSeedsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Marketplace',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inventory Management Section
            _buildSectionCard(
              title: 'Inventory Management',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStockInput('Cotton Bolls', cottonBollsController, 'kg'),
                  const SizedBox(height: 16),
                  _buildStockInput(
                      'Cotton Lint', cottonLintController, 'bales'),
                  const SizedBox(height: 16),
                  _buildStockInput('Cotton Seeds', cottonSeedsController, 'kg'),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle update stock levels
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Stock levels updated successfully!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Update Stock Levels',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Future Stock Outlook Section
            _buildSectionCard(
              title: 'Future Stock Outlook',
              child: Container(
                height: 200,
                child: CustomPaint(
                  painter: StockGraphPainter(),
                  child: Container(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Available Buyers Section
            _buildSectionCard(
              title: 'Available Buyers',
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio:
                        constraints.maxWidth < 400 ? 1.1 : 1.4,
                    children: [
                      _buildBuyerCard(
                        companyName: 'AgriCorp Global',
                        description:
                            'Seeking 1000 bales of premium long-staple cotton monthly.',
                        contactIcon: Icons.chat_bubble,
                        contactText: 'Via Platform Chat',
                      ),
                      _buildBuyerCard(
                        companyName: 'Textile Innovations Inc.',
                        description:
                            'Requires 500kg of organic cotton for sustainable fabrics.',
                        contactIcon: Icons.email,
                        contactText: 'Email: contact@textileinnov.com',
                      ),
                      _buildBuyerCard(
                        companyName: 'Local Ginning Co.',
                        description:
                            'Purchasing raw cotton bolls weekly. Flexible volumes.',
                        contactIcon: Icons.phone,
                        contactText: 'Phone: +1 (555) 123-4567',
                      ),
                      _buildBuyerCard(
                        companyName: 'Eco-Wear Apparel',
                        description:
                            'Looking for ethical and traceable cotton sources.',
                        contactIcon: Icons.chat_bubble,
                        contactText: 'Via Platform Chat',
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            0, // Dashboard tab is active (since this is accessed from dashboard)
        selectedItemColor: const Color(0xFF5FA62C),
        unselectedItemColor: Colors.black38,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Harvest()),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PestAlertsPage()),
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const NotificationsPage()),
            );
          } else if (index == 4) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const SettingsProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
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
            icon: Icon(Icons.notifications_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildStockInput(
      String label, TextEditingController controller, String unit) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.green),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          unit,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBuyerCard({
    required String companyName,
    required String description,
    required IconData contactIcon,
    required String contactText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      contactIcon,
                      color: Colors.grey[600],
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      contactText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              // Handle connect action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Connecting with $companyName...')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Connect',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StockGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final pointPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw axes
    final leftMargin = 40.0;
    final bottomMargin = 30.0;
    final rightMargin = 20.0;
    final topMargin = 20.0;

    // Y-axis
    canvas.drawLine(
      Offset(leftMargin, topMargin),
      Offset(leftMargin, size.height - bottomMargin),
      Paint()
        ..color = Colors.grey[300]!
        ..strokeWidth = 1,
    );

    // X-axis
    canvas.drawLine(
      Offset(leftMargin, size.height - bottomMargin),
      Offset(size.width - rightMargin, size.height - bottomMargin),
      Paint()
        ..color = Colors.grey[300]!
        ..strokeWidth = 1,
    );

    // Y-axis labels
    final yLabels = [
      '0 bales',
      '80 bales',
      '160 bales',
      '240 bales',
      '320 bales'
    ];
    for (int i = 0; i < yLabels.length; i++) {
      final y = size.height -
          bottomMargin -
          (i * (size.height - bottomMargin - topMargin) / 4);
      final textPainter = TextPainter(
        text: TextSpan(
          text: yLabels[i],
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(5, y - textPainter.height / 2));
    }

    // X-axis labels
    final xLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    for (int i = 0; i < xLabels.length; i++) {
      final x = leftMargin + (i * (size.width - leftMargin - rightMargin) / 5);
      final textPainter = TextPainter(
        text: TextSpan(
          text: xLabels[i],
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(x - textPainter.width / 2, size.height - bottomMargin + 5));
    }

    // Draw data points and lines
    final dataPoints = [
      {'x': 0, 'y': 160}, // Jan
      {'x': 1, 'y': 180}, // Feb
      {'x': 2, 'y': 200}, // Mar
      {'x': 3, 'y': 240}, // Apr
      {'x': 4, 'y': 280}, // May
      {'x': 5, 'y': 300}, // Jun
    ];

    final dataPoints2 = [
      {'x': 0, 'y': 160}, // Jan
      {'x': 1, 'y': 170}, // Feb
      {'x': 2, 'y': 190}, // Mar
      {'x': 3, 'y': 220}, // Apr
      {'x': 4, 'y': 240}, // May
      {'x': 5, 'y': 260}, // Jun
    ];

    // Draw first line
    _drawDataLine(canvas, dataPoints, size, leftMargin, bottomMargin, topMargin,
        rightMargin, paint, pointPaint);

    // Draw second line
    _drawDataLine(canvas, dataPoints2, size, leftMargin, bottomMargin,
        topMargin, rightMargin, paint, pointPaint);
  }

  void _drawDataLine(
      Canvas canvas,
      List<Map<String, int>> dataPoints,
      Size size,
      double leftMargin,
      double bottomMargin,
      double topMargin,
      double rightMargin,
      Paint paint,
      Paint pointPaint) {
    final path = Path();
    bool firstPoint = true;

    for (int i = 0; i < dataPoints.length; i++) {
      final point = dataPoints[i];
          (point['x']! * (size.width - leftMargin - rightMargin) / 5);
      final y = size.height -e.width - leftMargin - rightMargin) / 5);
          bottomMargin -ght -
          ((point['y']! / 320.0) * (size.height - bottomMargin - topMargin));
          ((point['y']! / 320.0) * (size.height - bottomMargin - topMargin));
      if (firstPoint) {
        path.moveTo(x, y);
        firstPoint = false;
      } else {oint = false;
        path.lineTo(x, y);
      } path.lineTo(x, y);
      }
      // Draw point
      canvas.drawCircle(Offset(x, y), 3, pointPaint);
    } canvas.drawCircle(Offset(x, y), 3, pointPaint);
    }
    canvas.drawPath(path, paint);
  } canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} bool shouldRepaint(CustomPainter oldDelegate) => false;
}
