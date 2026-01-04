import 'package:flutter/material.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medicines')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          MedicineTile(name: "Paracetamol", price: "₹20"),
          MedicineTile(name: "Cough Syrup", price: "₹120"),
          MedicineTile(name: "Vitamin C", price: "₹80"),
        ],
      ),
    );
  }
}

class MedicineTile extends StatelessWidget {
  final String name;
  final String price;

  const MedicineTile({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(price),
        trailing: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
