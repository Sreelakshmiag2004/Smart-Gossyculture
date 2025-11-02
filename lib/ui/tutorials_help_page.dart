import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'Harvest.dart';
import 'pest_alerts_page.dart';
import 'notifications_page.dart';
import 'settings_profile_page.dart';

class TutorialsHelpPage extends StatefulWidget {
  const TutorialsHelpPage({super.key});

  @override
  State<TutorialsHelpPage> createState() => _TutorialsHelpPageState();
}

class _TutorialsHelpPageState extends State<TutorialsHelpPage> {
  bool gettingStartedExpanded = true;
  bool monitoringExpanded = false;
  bool pestsExpanded = false;
  bool harvestExpanded = false;

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
          'Tutorials & Help',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Guides & Support Header
            const Text(
              'Guides & Support',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find step-by-step instructions and video tutorials to master BollBot.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            
            // Getting Started with BollBot Section (Expanded)
            _buildTutorialSection(
              icon: Icons.eco,
              title: 'Getting Started with BollBot',
              description: 'Learn the essentials of setting up and navigating the app.',
              isExpanded: gettingStartedExpanded,
              onToggle: () {
                setState(() {
                  gettingStartedExpanded = !gettingStartedExpanded;
                });
              },
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome to BollBot! This guide will walk you through the initial setup, from creating your farm profile to understanding the main dashboard. We recommend starting here to maximize your app experience.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tutorial Image
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.agriculture,
                            size: 60,
                            color: Colors.green[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tutorial Image',
                            style: TextStyle(
                              color: Colors.green[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'First, ensure your location services are enabled for accurate weather and soil data. Then, personalize your farm profile by adding your cotton variety and planting dates. The dashboard will then display real-time insights based on your input.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Video Placeholder
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Watch video: Dashboard Overview.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'For advanced features like connecting smart sensors, navigate to the \'Settings\' tab and select \'Device Pairing\'.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Monitoring Cotton Health Section (Collapsed)
            _buildTutorialSection(
              icon: Icons.show_chart,
              title: 'Monitoring Cotton Health',
              description: 'Understand boll count, moisture levels, and growth metrics.',
              isExpanded: monitoringExpanded,
              onToggle: () {
                setState(() {
                  monitoringExpanded = !monitoringExpanded;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Identifying Pests & Diseases Section (Collapsed)
            _buildTutorialSection(
              icon: Icons.bug_report,
              title: 'Identifying Pests & Diseases',
              description: 'Leverage AI for early detection and recommended treatments.',
              isExpanded: pestsExpanded,
              onToggle: () {
                setState(() {
                  pestsExpanded = !pestsExpanded;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Logging Your Harvest Section (Collapsed)
            _buildTutorialSection(
              icon: Icons.upload_file,
              title: 'Logging Your Harvest',
              description: 'Record yield data, export reports, and connect with buyers.',
              isExpanded: harvestExpanded,
              onToggle: () {
                setState(() {
                  harvestExpanded = !harvestExpanded;
                });
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Settings tab is active (since this is accessed from settings)
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
              MaterialPageRoute(builder: (context) => const NotificationsPage()),
            );
          } else if (index == 4) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SettingsProfilePage()),
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

  Widget _buildTutorialSection({
    required IconData icon,
    required String title,
    required String description,
    required bool isExpanded,
    required VoidCallback onToggle,
    Widget? expandedContent,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isExpanded ? Colors.green[50] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpanded ? Colors.green[200]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onToggle,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
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
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expanded Content
          if (isExpanded && expandedContent != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: expandedContent,
            ),
        ],
      ),
    );
  }
}
