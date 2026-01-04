import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../main.dart'; // To access themeNotifier
import 'doctor_privacy_policy_screen.dart';

class DoctorMyProfileScreen extends StatefulWidget {
  const DoctorMyProfileScreen({super.key});

  @override
  State<DoctorMyProfileScreen> createState() => _DoctorMyProfileScreenState();
}

class _DoctorMyProfileScreenState extends State<DoctorMyProfileScreen> {
  String _doctorName = 'Dr. Awnish Mondal';
  String _specialization = 'Cardiologist • MBBS, MD';
  String _hospital = 'Fortis Hospital, Kolkata';

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _doctorName);
    final specController = TextEditingController(text: _specialization);
    final hospitalController = TextEditingController(text: _hospital);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: specController,
                decoration: const InputDecoration(
                  labelText: 'Specialization & Degree',
                ),
              ),
              TextField(
                controller: hospitalController,
                decoration: const InputDecoration(labelText: 'Hospital/Clinic'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _doctorName = nameController.text;
                _specialization = specController.text;
                _hospital = hospitalController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    bool emailNotifications = true;
    bool pushNotifications = true;
    bool appointmentReminders = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Notification Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Email Notifications'),
                value: emailNotifications,
                onChanged: (val) =>
                    setDialogState(() => emailNotifications = val),
                activeColor: Colors.teal,
              ),
              SwitchListTile(
                title: const Text('Push Notifications'),
                value: pushNotifications,
                onChanged: (val) =>
                    setDialogState(() => pushNotifications = val),
                activeColor: Colors.teal,
              ),
              SwitchListTile(
                title: const Text('Appointment Reminders'),
                value: appointmentReminders,
                onChanged: (val) =>
                    setDialogState(() => appointmentReminders = val),
                activeColor: Colors.teal,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSecuritySettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security & Privacy'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.lock_outline, color: Colors.red),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password reset link sent to registered email',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.fingerprint, color: Colors.blue),
              title: const Text('Biometric Authentication'),
              trailing: const Text('Off', style: TextStyle(color: Colors.grey)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.privacy_tip_outlined,
                color: Colors.green,
              ),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorPrivacyPolicyScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHelpSupport() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help & Support',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSupportTile(
              Icons.email_outlined,
              'Email Us',
              'support@caresphere.com',
            ),
            _buildSupportTile(
              Icons.phone_outlined,
              'Call Support',
              '+91 1800-123-456',
            ),
            _buildSupportTile(
              Icons.live_help_outlined,
              'Visit Help Center',
              'caresphere.com/help',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      subtitle: Text(value),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showEditProfileDialog,
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Header
            Center(
              child: Column(
                children: [
                  Stack(
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
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Photo upload coming soon'),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _doctorName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _specialization,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _hospital,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Statistics Row
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    'Consultations',
                    '1.2k',
                    Icons.medical_services,
                    Colors.blue,
                  ),
                  Container(width: 1, height: 40, color: Colors.grey.shade300),
                  _buildStatItem('Rating', '4.9', Icons.star, Colors.amber),
                  Container(width: 1, height: 40, color: Colors.grey.shade300),
                  _buildStatItem(
                    'Experience',
                    '12 yrs',
                    Icons.work,
                    Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Profile Sections
            _buildSectionTitle('Professional Information'),
            _buildProfileTile(
              Icons.badge_outlined,
              'License Number',
              'MC-123456789',
              Colors.indigo,
              null,
            ),
            _buildProfileTile(
              Icons.currency_rupee,
              'Consultation Fee',
              '₹500',
              Colors.green,
              null,
            ),
            _buildProfileTile(
              Icons.email_outlined,
              'Practice Email',
              'awnish@fortis.com',
              Colors.orange,
              null,
            ),
            _buildProfileTile(
              Icons.language_outlined,
              'Languages',
              'English, Hindi, Bengali',
              Colors.brown,
              null,
            ),
            _buildProfileTile(
              Icons.public,
              'Website',
              'www.dr-awnish.com',
              Colors.blue,
              null,
            ),

            const SizedBox(height: 24),

            _buildSectionTitle('Account Settings'),
            _buildProfileTile(
              Icons.notifications_none,
              'Notifications',
              'Manage alerts',
              Colors.teal,
              _showNotificationSettings,
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey,
              ),
            ),
            _buildProfileTile(
              Icons.security,
              'Security',
              'Password & Privacy',
              Colors.red,
              _showSecuritySettings,
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey,
              ),
            ),
            _buildProfileTile(
              Icons.help_outline,
              'Help & Support',
              'FAQ, Contact us',
              Colors.blue,
              _showHelpSupport,
              trailing: const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey,
              ),
            ),

            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (context, mode, _) {
                return _buildProfileTile(
                  mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                  'Dark Mode',
                  mode == ThemeMode.dark ? 'Enabled' : 'Disabled',
                  mode == ThemeMode.dark ? Colors.amber : Colors.blueGrey,
                  null,
                  trailing: Switch(
                    value: mode == ThemeMode.dark,
                    onChanged: (val) {
                      themeNotifier.value = val
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                    activeColor: Colors.teal,
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await AuthService().logout();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text(
                  'LOGOUT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.red.shade100),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors
                .teal, // Use teal for section titles for better visibility
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTile(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback? onTap, {
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
