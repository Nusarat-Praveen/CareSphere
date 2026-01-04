import 'package:flutter/material.dart';

class HelpFaqScreen extends StatelessWidget {
  const HelpFaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQ'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.help_center, size: 80, color: Colors.teal),
            const SizedBox(height: 16),
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Find answers to common questions',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            _buildFaqCategory('Account & Profile', [
              _FaqItem(
                question: 'How do I create an account?',
                answer:
                    'Tap on "Create Account" on the login screen, fill in your details including name, email, phone number, age, gender, and blood group, then verify your phone number with OTP.',
              ),
              _FaqItem(
                question: 'How do I update my profile?',
                answer:
                    'Go to the Profile tab, tap on "Edit Profile", make your changes, and save. You can update your name, contact information, and other personal details.',
              ),
              _FaqItem(
                question: 'Can I change my phone number?',
                answer:
                    'Yes, go to Profile > Edit Profile and update your phone number. You will need to verify the new number with OTP.',
              ),
            ]),

            _buildFaqCategory('Appointments', [
              _FaqItem(
                question: 'How do I book an appointment?',
                answer:
                    'Go to the Doctors tab, select a doctor, tap "Book Appointment", choose your preferred date and time, and confirm the booking.',
              ),
              _FaqItem(
                question: 'Can I cancel or reschedule an appointment?',
                answer:
                    'Yes, go to the Appointments tab, select your appointment, and choose either "Reschedule" or "Cancel". Cancellations made 24 hours in advance are free.',
              ),
              _FaqItem(
                question: 'How do I join a video consultation?',
                answer:
                    'At the scheduled time, go to your appointment details and tap "Join Video Call". Make sure you have a stable internet connection.',
              ),
            ]),

            _buildFaqCategory('Medicine Orders', [
              _FaqItem(
                question: 'How do I order medicines?',
                answer:
                    'Go to the Medicine Shop, search or browse for medicines, add them to cart, and proceed to checkout. You can also upload a prescription for prescription medicines.',
              ),
              _FaqItem(
                question: 'What payment methods are accepted?',
                answer:
                    'We accept UPI, credit/debit cards, net banking, and cash on delivery for medicine orders.',
              ),
              _FaqItem(
                question: 'How long does delivery take?',
                answer:
                    'Standard delivery takes 2-3 business days. Express delivery (available in select cities) delivers within 24 hours.',
              ),
            ]),

            _buildFaqCategory('Health Records', [
              _FaqItem(
                question: 'How do I upload health records?',
                answer:
                    'Go to Health Records, tap the "+" button, select the type of record (prescription, report, etc.), and upload the file or take a photo.',
              ),
              _FaqItem(
                question: 'Is my health data secure?',
                answer:
                    'Yes, all your health data is encrypted and stored securely. We follow strict privacy policies and comply with healthcare data protection regulations.',
              ),
              _FaqItem(
                question: 'Can I share my records with doctors?',
                answer:
                    'Yes, during an appointment, you can share specific health records with your doctor directly through the app.',
              ),
            ]),

            _buildFaqCategory('Technical Issues', [
              _FaqItem(
                question: 'The app is not working properly. What should I do?',
                answer:
                    'Try closing and reopening the app. If the issue persists, check for app updates in the Play Store/App Store. You can also clear the app cache in your device settings.',
              ),
              _FaqItem(
                question: 'I\'m not receiving notifications',
                answer:
                    'Go to Settings and ensure "Push Notifications" is enabled. Also check your device notification settings to allow notifications from CareSphere.',
              ),
              _FaqItem(
                question: 'How do I enable dark mode?',
                answer:
                    'Go to Settings and toggle the "Dark Mode" switch. The app will immediately switch to dark theme.',
              ),
            ]),

            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade400, Colors.teal.shade700],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.support_agent,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Still need help?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Contact our support team',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildContactButton(Icons.email, 'Email', () {}),
                      _buildContactButton(Icons.phone, 'Call', () {}),
                      _buildContactButton(Icons.chat, 'Chat', () {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqCategory(String category, List<_FaqItem> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => _buildFaqItem(item)),
        ],
      ),
    );
  }

  Widget _buildFaqItem(_FaqItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            item.question,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                item.answer,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  _FaqItem({required this.question, required this.answer});
}
