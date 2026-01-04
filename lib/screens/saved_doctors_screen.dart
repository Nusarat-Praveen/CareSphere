import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';

class SavedDoctorsScreen extends StatelessWidget {
  const SavedDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Subset of doctors acting as "saved"
    final savedDoctors = [
      {
        'name': 'Dr. Anjali Sharma',
        'speciality': 'Cardiologist',
        'experience': '12 years',
        'rating': 4.8,
        'patients': '1.5k+',
        'location': 'City Heart Hospital, Mumbai',
        'about':
            'Dr. Anjali Sharma is a renowned Cardiologist with over a decade of experience in treating complex heart conditions. She is dedicated to providing personalized care to her patients.',
        'availability': 'Mon - Sat, 10:00 AM - 04:00 PM',
        'fee': '₹800',
      },
      {
        'name': 'Dr. Manoj Bhargava',
        'speciality': 'Orthopedic Surgeon',
        'experience': '15 years',
        'rating': 4.9,
        'patients': '3k+',
        'location': 'Bone & Joint Institute, Chennai',
        'about':
            'Dr. Manoj Bhargava is a senior Orthopedic Surgeon specializing in joint replacement and sports injuries. He has performed over 500 successful surgeries.',
        'availability': 'Mon - Fri, 08:00 AM - 03:00 PM',
        'fee': '₹1000',
      },
    ];

    return Scaffold(
      // backgroundColor: handled by theme
      appBar: AppBar(
        title: const Text('Saved Doctors'),
        centerTitle: true,
        // backgroundColor: handled by theme
        elevation: 0,
        // titleTextStyle: handled by theme
        // iconTheme: handled by theme
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedDoctors.length,
        itemBuilder: (context, index) {
          final doctor = savedDoctors[index];
          return _doctorCard(context, doctor);
        },
      ),
    );
  }

  Widget _doctorCard(BuildContext context, Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.teal.shade100,
              child: const Icon(Icons.person, size: 32, color: Colors.teal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor['speciality'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Experience: ${doctor['experience']}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        doctor['rating'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorProfileScreen(doctor: doctor),
                  ),
                );
              },
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}
