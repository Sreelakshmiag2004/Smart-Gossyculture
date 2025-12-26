import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'Harvest.dart';
import 'notifications_page.dart';
import 'settings_profile_page.dart';
import 'widgets/bottom_nav_bar.dart';

class PestAlertsPage extends StatelessWidget {
  const PestAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Slightly off-white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Dashboard()),
            (route) => false,
          ),
        ),
        title: const Text(
          'Pest & Disease Alerts',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Scan View Section
            _buildLiveScanSection(),
            const SizedBox(height: 24),
            
            // Detected Issues Section
            _buildSectionHeader('Detected Issues'),
            const SizedBox(height: 12),
            _buildIssueCard(
              icon: Icons.bug_report_rounded,
              iconColor: Colors.redAccent,
              title: 'Cotton Bollworm Infestation',
              confidence: '92%',
              severityColor: Colors.red,
              recommendation: 'Apply recommended insecticide within 24 hours. Monitor affected area closely.',
            ),
            const SizedBox(height: 12),
            _buildIssueCard(
              icon: Icons.spa_rounded,
              iconColor: Colors.orange,
              title: 'Bacterial Blight',
              confidence: '78%',
              severityColor: Colors.orange,
              recommendation: 'Prune infected leaves and ensure proper field sanitation.',
            ),
            const SizedBox(height: 12),
            _buildIssueCard(
              icon: Icons.search_rounded,
              iconColor: Colors.green,
              title: 'Spider Mite Presence',
              confidence: '65%',
              severityColor: Colors.green,
              recommendation: 'Light presence detected. Introduce natural predators or use mild organic control.',
            ),
            
            const SizedBox(height: 28),
            
            // Spray History Section
            _buildSectionHeader('Spray History'),
            const SizedBox(height: 12),
            _buildSprayHistoryTimeline(),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black87,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildLiveScanSection() {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Live Scan View',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                     Container(
                      width: 8, 
                      height: 8, 
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Live',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Plant Image
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
                image: const DecorationImage(
                  image: AssetImage('assets/MLPhoto.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                 // Bounding Boxes (Mock)
                  Positioned(
                    top: 40,
                    left: 60,
                    child: _buildBoundingBox('Bollworm', Colors.red, 70, 40),
                  ),
                  Positioned(
                    top: 80,
                    right: 80,
                    child: _buildBoundingBox('Aphids', Colors.amber, 60, 35),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.camera_alt_outlined,
                  label: 'Capture',
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.medical_services_outlined,
                  label: 'Treat',
                  color: Colors.green,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoundingBox(String label, Color color, double w, double h) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -16,
            left: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              color: color,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildIssueCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String confidence,
    required Color severityColor,
    required String recommendation,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 6,
                color: severityColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(icon, color: iconColor, size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: severityColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Confidence: $confidence',
                                    style: TextStyle(
                                      color: severityColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        recommendation,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSprayHistoryTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          title: 'Insecticide Application',
          subtitle: 'Applied Cypermethrin (200ml/acre)',
          date: 'Oct 26',
          isFirst: true,
          isLast: false,
          color: Colors.blue,
        ),
        _buildTimelineItem(
          title: 'Fungicide Application',
          subtitle: 'Copper Oxychloride (1.5kg/acre)',
          date: 'Oct 18',
          isFirst: false,
          isLast: false,
          color: Colors.orange,
        ),
        _buildTimelineItem(
          title: 'Routine Checkup',
          subtitle: 'No issues found',
          date: 'Oct 05',
          isFirst: false,
          isLast: true,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required String date,
    required bool isFirst,
    required bool isLast,
    required Color color,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Column(
              children: [
                if (!isFirst) Container(width: 2, height: 16, color: Colors.grey[300]),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 4,
                      )
                    ]
                  ),
                ),
                if (!isLast) Expanded(child: Container(width: 2, color: Colors.grey[300])),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
