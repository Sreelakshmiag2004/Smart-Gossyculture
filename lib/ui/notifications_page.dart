import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'Harvest.dart';
import 'pest_alerts_page.dart';
import 'settings_profile_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // High Urgency Notification 1
            _buildNotificationCard(
              urgency: 'High Urgency',
              urgencyColor: Colors.red,
              urgencyIcon: Icons.warning,
              message: 'Pest detected in Zone B. Immediate action recommended.',
              timeAgo: '2 mins ago',
            ),
            const SizedBox(height: 12),

            // Medium Urgency Notification 1
            _buildNotificationCard(
              urgency: 'Medium Urgency',
              urgencyColor: Colors.orange,
              urgencyIcon: Icons.warning_amber,
              message: 'Low battery on sensor unit #4. Please recharge soon.',
              timeAgo: '1 hour ago',
            ),
            const SizedBox(height: 12),

            // Low Urgency Notification 1
            _buildNotificationCard(
              urgency: 'Low Urgency',
              urgencyColor: Colors.green,
              urgencyIcon: Icons.info,
              message:
                  'Harvest ready for collection in Field 3. Estimated yield: 2.5 tons.',
              timeAgo: '3 hours ago',
            ),
            const SizedBox(height: 12),

            // Low Urgency Notification 2
            _buildNotificationCard(
              urgency: 'Low Urgency',
              urgencyColor: Colors.green,
              urgencyIcon: Icons.info,
              message:
                  'New software update available. Install for improved pest detection algorithms.',
              timeAgo: 'Yesterday',
            ),
            const SizedBox(height: 12),

            // Medium Urgency Notification 2
            _buildNotificationCard(
              urgency: 'Medium Urgency',
              urgencyColor: Colors.orange,
              urgencyIcon: Icons.warning_amber,
              message:
                  'Abnormal moisture levels detected in Sector A. Review irrigation schedule.',
              timeAgo: '2 days ago',
            ),
            const SizedBox(height: 12),

            // High Urgency Notification 2
            _buildNotificationCard(
              urgency: 'High Urgency',
              urgencyColor: Colors.red,
              urgencyIcon: Icons.warning,
              message:
                  'Critical system error on main gateway. Contact support immediately.',
              timeAgo: '3 days ago',
            ),
            const SizedBox(height: 12),

            // Low Urgency Notification 3
            _buildNotificationCard(
              urgency: 'Low Urgency',
              urgencyColor: Colors.green,
              urgencyIcon: Icons.info,
              message:
                  'New buyer inquiry for organic cotton. Check marketplace offers.',
              timeAgo: '4 days ago',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Notifications tab is active
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

  Widget _buildNotificationCard({
    required String urgency,
    required Color urgencyColor,
    required IconData urgencyIcon,
    required String message,
    required String timeAgo,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Urgency Badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: urgencyColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      urgencyIcon,
                      color: Colors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      urgency,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                timeAgo,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Notification Message
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // View Details Link
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle view details
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.green,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
