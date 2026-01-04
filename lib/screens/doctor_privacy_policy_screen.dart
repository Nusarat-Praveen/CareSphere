import 'package:flutter/material.dart';

class DoctorPrivacyPolicyScreen extends StatelessWidget {
  const DoctorPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy for Medical Professionals',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Last Updated: December 27, 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Introduction',
              'CareSphere is committed to protecting the privacy of our medical professionals and their patients. This policy outlines how we handle your professional data and the patient information you manage through our platform.',
            ),
            _buildSection(
              '2. Data Collection',
              'We collect professional information including your name, specialization, medical license details, hospital affiliation, and clinical history to verify your professional status and improve platform services.',
            ),
            _buildSection(
              '3. Patient Confidentiality (HIPAA/GDPR Compliance)',
              'All patient records, prescriptions, and consultation notes are encrypted. CareSphere does not access individual patient data without your explicit professional request for support. You are responsible for maintaining the confidentiality of patient data in accordance with local healthcare regulations.',
            ),
            _buildSection(
              '4. Data Security',
              'We implement industry-standard AES-256 encryption for data at rest and TLS 1.3 for data in transit. Your professional account is protected by multi-factor authentication options.',
            ),
            _buildSection(
              '5. Information Sharing',
              'We do not sell your professional data to third parties. Information may only be shared with verified healthcare partners or regulators when required by law or to facilitate your professional practice (e.g., hospital integrations).',
            ),
            _buildSection(
              '6. Your Rights',
              'You have the right to access, rectify, or request the deletion of your professional profile. Please contact our Data Protection Officer for any privacy-related concerns.',
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                '© 2025 CareSphere Healthcare Systems',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
