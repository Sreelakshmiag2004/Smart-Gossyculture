import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF4), // Match app background
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
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all, color: Colors.green),
            onPressed: () {
              // Mark all as read action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications marked as read')),
              );
            },
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Today'),
          _buildNotificationCard(
            context,
            urgency: 'High Urgency',
            urgencyColor: Colors.red,
            iconData: Icons.warning_rounded,
            title: 'Pest Detected!',
            message: 'Aphids detected in Zone B. Immediate action recommended.',
            time: '2 mins ago',
            isUnread: true,
          ),
          _buildNotificationCard(
            context,
            urgency: 'Medium Urgency',
            urgencyColor: Colors.orange,
            iconData: Icons.battery_alert_rounded,
            title: 'Low Battery',
            message: 'Sensor unit #4 battery is below 15%.',
            time: '1 hour ago',
            isUnread: true,
          ),
          
          const SizedBox(height: 16),
          _buildSectionHeader('Yesterday'),
           _buildNotificationCard(
            context,
            urgency: 'Low Urgency',
            urgencyColor: Colors.green,
            iconData: Icons.agriculture_rounded,
            title: 'Harvest Ready',
            message: 'Field 3 is ready for harvest. Estimated yield: 2.5 tons.',
            time: 'Yesterday, 4:00 PM',
            isUnread: false,
          ),
          _buildNotificationCard(
            context,
            urgency: 'Low Urgency',
            urgencyColor: Colors.blue,
            iconData: Icons.system_update_rounded,
            title: 'System Update',
            message: 'New features available for pest detection.',
            time: 'Yesterday, 9:30 AM',
            isUnread: false,
          ),

          const SizedBox(height: 16),
          _buildSectionHeader('Older'),
          _buildNotificationCard(
            context,
            urgency: 'Medium Urgency',
            urgencyColor: Colors.orange,
            iconData: Icons.water_drop_rounded,
            title: 'Moisture Alert',
            message: 'Abnormal moisture levels in Sector A.',
            time: '2 days ago',
            isUnread: false,
          ),
           _buildNotificationCard(
            context,
            urgency: 'High Urgency',
            urgencyColor: Colors.red,
            iconData: Icons.error_outline_rounded,
            title: 'Gateway Error',
            message: 'Critical error resolved on main gateway.',
            time: '3 days ago',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required String urgency,
    required Color urgencyColor,
    required IconData iconData,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            // Handle tap
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: urgencyColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    color: urgencyColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
