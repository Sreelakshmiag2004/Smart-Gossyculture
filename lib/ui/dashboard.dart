import 'package:flutter/material.dart';
import 'Harvest.dart';
import 'pest_alerts_page.dart';
import 'settings_profile_page.dart';
import 'notifications_page.dart';
import 'marketplace_page.dart';
import 'widgets/bottom_nav_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Neutral professional background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        // No title, clean look
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black87), // Outlined icon
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsProfilePage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(18),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF5FA62C),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              const Text(
                'Welcome back, Farmer!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26, // Larger, more prominent
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'SUNDAY, SEPTEMBER 7, 2025', // Uppercase for elegant style
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 24),

              // Cotton Boll Count Card
              _buildStatusCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Cotton Boll Count',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '1,250',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36, // Bigger impact
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Estimated ripe bolls in sector A',
                            style: TextStyle(
                              color: Colors.green, // Highlight positive info
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F7E5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.agriculture, // Changed icon to agriculture for variety check
                          color: Color(0xFF5FA62C), size: 32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Split Row: Moisture & Power
              Row(
                children: [
                  Expanded(
                    child: _buildStatusCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Moisture',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              Icon(
                                Icons.water_drop,
                                color: Color(0xFF00B2FF),
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '68%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Optimal',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatusCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Power',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              Icon(
                                Icons.flash_on,
                                color: Color(0xFFFFC107), // Amber for power
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '95%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Solar Active',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Pest Alert Section (Redesigned)
              Material(
                color: const Color(0xFFFFF2F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFFFFCCC7)),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PestAlertsPage(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF4D4F),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.warning_amber_rounded,
                              color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Action Required',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFFCF1322),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Aphid infestation detected in Sector C.',
                                style: TextStyle(
                                  color: Color(0xFFA8071A),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Color(0xFFCF1322)),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),
              
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.5, // Wider buttons
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _DashboardButton(
                        icon: Icons.search,
                        label: 'Monitor',
                        color: const Color(0xFF4A90E2),
                        onTap: () {},
                      ),
                      _DashboardButton(
                        icon: Icons.list_alt,
                        label: 'Logs',
                        color: const Color(0xFF5FA62C),
                        onTap: () {
                           Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const Harvest()),
                          );
                        },
                      ),
                      _DashboardButton(
                        icon: Icons.qr_code_scanner,
                        label: 'Scan',
                         color: const Color(0xFF9C27B0),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PestAlertsPage(),
                            ),
                          );
                        },
                      ),
                      _DashboardButton(
                        icon: Icons.storefront,
                        label: 'Market',
                         color: const Color(0xFFFF9800),
                        onTap: () {
                           Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MarketplacePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildStatusCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Very subtle shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DashboardButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(16),
             border: Border.all(color: Colors.grey.withOpacity(0.1)),
             boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
             ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
