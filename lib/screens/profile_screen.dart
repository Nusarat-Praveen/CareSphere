import 'package:flutter/material.dart';
import 'appointment_screen.dart';
import 'medical_history_screen.dart';
import 'saved_doctors_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: handled by theme
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        // backgroundColor: handled by theme
        elevation: 0,
        // titleTextStyle: handled by theme
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // User Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.teal.shade100,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Rajesh Kumar",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      // color: handled by theme
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "+91 98765 43210",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Menu Options
            _buildProfileOption(
              context,
              icon: Icons.calendar_month,
              title: "My Appointments",
              subtitle: "Upcoming & Past",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppointmentScreen(),
                  ),
                );
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.history,
              title: "Medical History",
              subtitle: "Records & Prescriptions",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MedicalHistoryScreen(),
                  ),
                );
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.favorite_border,
              title: "Saved Doctors",
              subtitle: "Your favorites",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedDoctorsScreen(),
                  ),
                );
              },
            ),
            const Divider(height: 40),
            _buildProfileOption(
              context,
              icon: Icons.settings,
              title: "Settings",
              subtitle: "Notifications, Privacy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.logout,
              title: "Logout",
              subtitle: "Sign out of your account",
              iconColor: Colors.redAccent,
              textColor: Colors.redAccent,
              onTap: () {
                // Navigate back to login
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = Colors.teal,
    Color? textColor,
  }) {
    final theme = Theme.of(context);
    textColor ??= theme.textTheme.bodyLarge?.color;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
