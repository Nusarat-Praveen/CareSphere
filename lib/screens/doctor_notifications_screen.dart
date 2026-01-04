import 'package:flutter/material.dart';

class DoctorNotificationsScreen extends StatelessWidget {
  const DoctorNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read'),
                ),
              );
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationGroup('Today'),
          _buildNotificationItem(
            context,
            'New Appointment',
            'You have a new appointment with Rajesh Kumar today at 10:30 AM.',
            'Just now',
            Icons.calendar_today,
            Colors.blue,
            isNew: true,
          ),
          _buildNotificationItem(
            context,
            'Patient Arrived',
            'Priya Sharma has arrived for her 10:45 AM consultation.',
            '15 mins ago',
            Icons.person_pin,
            Colors.green,
            isNew: true,
          ),
          const SizedBox(height: 24),
          _buildNotificationGroup('Yesterday'),
          _buildNotificationItem(
            context,
            'Report Uploaded',
            'Sanjay Rao has uploaded his latest blood test reports.',
            'Yesterday, 4:30 PM',
            Icons.upload_file,
            Colors.orange,
          ),
          _buildNotificationItem(
            context,
            'Appointment Cancelled',
            'Neha Agarwal has cancelled her appointment for tomorrow.',
            'Yesterday, 2:15 PM',
            Icons.cancel,
            Colors.red,
          ),
          _buildNotificationItem(
            context,
            'System Update',
            'CareSphere has been updated to version 2.1.0 with new features.',
            'Yesterday, 10:00 AM',
            Icons.system_update_alt,
            Colors.teal,
          ),
          const SizedBox(height: 24),
          _buildNotificationGroup('Earlier'),
          _buildNotificationItem(
            context,
            'Medicine News',
            'New guidelines for managing hypertension have been released.',
            '2 days ago',
            Icons.medical_services,
            Colors.indigo,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationGroup(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    String title,
    String message,
    String time,
    IconData icon,
    Color color, {
    bool isNew = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNew ? color.withOpacity(0.05) : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: isNew ? Border.all(color: color.withOpacity(0.2)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isNew)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
