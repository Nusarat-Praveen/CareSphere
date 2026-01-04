import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          DoctorCard(name: "Dr. Sharma", specialty: "Cardiologist"),
          DoctorCard(name: "Dr. Mehta", specialty: "Dermatologist"),
          DoctorCard(name: "Dr. Khan", specialty: "Pediatrician"),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.purple),
        title: Text(name),
        subtitle: Text(specialty),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text("Book"),
        ),
      ),
    );
  }
}
