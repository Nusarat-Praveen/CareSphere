import 'package:flutter/material.dart';

class MedicalHistoryScreen extends StatelessWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: handled by theme
      appBar: AppBar(
        title: const Text('Medical History'),
        centerTitle: true,
        // backgroundColor: handled by theme
        elevation: 0,
        // titleTextStyle: handled by theme
        // iconTheme: handled by theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Diagnoses"),
            _buildHistoryCard(
              context,
              title: "Viral Fever",
              date: "Oct 15, 2024",
              subtitle: "Dr. Anjali Sharma",
              icon: Icons.personal_injury,
              color: Colors.orange,
            ),
            _buildHistoryCard(
              context,
              title: "Regular Checkup",
              date: "Aug 22, 2024",
              subtitle: "Dr. Deepak Lamba",
              icon: Icons.health_and_safety,
              color: Colors.teal,
            ),

            const SizedBox(height: 24),
            _buildSectionHeader("Prescriptions"),
            _buildHistoryCard(
              context,
              title: "Paracetamol 500mg",
              date: "Oct 15, 2024",
              subtitle: "2 times a day",
              icon: Icons.medication,
              color: Colors.blue,
            ),
            _buildHistoryCard(
              context,
              title: "Vitamin D Supplement",
              date: "Aug 22, 2024",
              subtitle: "Once a day",
              icon: Icons.medication,
              color: Colors.blue,
            ),

            const SizedBox(height: 24),
            _buildSectionHeader("Lab Reports"),
            _buildHistoryCard(
              context,
              title: "Blood Test Report",
              date: "Oct 16, 2024",
              subtitle: "Pathology Lab",
              icon: Icons.description,
              color: Colors.purple,
              isDownloadable: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          // color: handled by theme
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    BuildContext context, {
    required String title,
    required String date,
    required String subtitle,
    required IconData icon,
    required Color color,
    bool isDownloadable = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              date,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ],
        ),
        trailing: isDownloadable
            ? IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Downloading Blood Test Report..."),
                      backgroundColor: Colors.teal,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.download_rounded, color: Colors.teal),
              )
            : null,
      ),
    );
  }
}
