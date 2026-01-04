import 'package:flutter/material.dart';
import 'report_detail_screen.dart';
import 'prescription_detail_screen.dart';

class HealthRecordScreen extends StatefulWidget {
  const HealthRecordScreen({super.key});

  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleUpload() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Upload Health Record",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.teal),
              title: const Text("Take a Photo"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.teal),
              title: const Text("Upload from Gallery"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.upload_file, color: Colors.teal),
              title: const Text("Upload PDF File"),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records'),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          tabs: const [
            Tab(text: "Vitals"),
            Tab(text: "Lab Reports"),
            Tab(text: "Prescriptions"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVitalsTab(),
          _buildLabReportsTab(),
          _buildPrescriptionsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleUpload,
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Record", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildVitalsTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        const Text(
          "Latest Vitals",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: [
            _vitalCard(
              title: "Blood Pressure",
              value: "120/80",
              unit: "mmHg",
              status: "Normal",
              icon: Icons.favorite,
              color: Colors.red,
            ),
            _vitalCard(
              title: "Blood Sugar",
              value: "95",
              unit: "mg/dL",
              status: "Normal",
              icon: Icons.water_drop,
              color: Colors.blue,
            ),
            _vitalCard(
              title: "Heart Rate",
              value: "72",
              unit: "bpm",
              status: "Optimal",
              icon: Icons.monitor_heart,
              color: Colors.pink,
            ),
            _vitalCard(
              title: "Weight",
              value: "68",
              unit: "kg",
              status: "Healthy",
              icon: Icons.scale,
              color: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          "Health Score",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade300, Colors.teal.shade600],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "85/100",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Your health is looking great!",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.insights, color: Colors.white, size: 40),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabReportsTab() {
    final List<Map<String, dynamic>> reports = [
      {
        "title": "Full Body Checkup",
        "date": "15 Dec 2025",
        "lab": "HealthCheck Labs",
        "status": "Normal",
        "observations":
            "Blood counts and biochemistry are within biological reference ranges.",
        "patientInfo": {
          "name": "Aarav Sharma",
          "age": "28",
          "gender": "Male",
          "reportId": "L-589234",
        },
        "results": [
          {
            "param": "Hemoglobin",
            "value": "14.5",
            "unit": "g/dL",
            "reference": "13.0 - 17.0",
          },
          {
            "param": "WBC Count",
            "value": "7200",
            "unit": "cells/mcL",
            "reference": "4500 - 11000",
          },
          {
            "param": "Glucose (Fasting)",
            "value": "92",
            "unit": "mg/dL",
            "reference": "70 - 100",
          },
          {
            "param": "Cholesterol",
            "value": "185",
            "unit": "mg/dL",
            "reference": "< 200",
          },
        ],
      },
      {
        "title": "Thyroid Profile",
        "date": "02 Oct 2025",
        "lab": "Metro Diagnostics",
        "status": "Normal",
        "observations": "Thyroid functions are well controlled.",
        "patientInfo": {
          "name": "Aarav Sharma",
          "age": "28",
          "gender": "Male",
          "reportId": "L-422187",
        },
        "results": [
          {
            "param": "T3, Total",
            "value": "1.2",
            "unit": "ng/mL",
            "reference": "0.8 - 2.0",
          },
          {
            "param": "T4, Total",
            "value": "8.5",
            "unit": "mcg/dL",
            "reference": "5.1 - 14.1",
          },
          {
            "param": "TSH",
            "value": "2.4",
            "unit": "uIU/mL",
            "reference": "0.4 - 4.2",
          },
        ],
      },
      {
        "title": "COVID-19 RT-PCR",
        "date": "20 Aug 2025",
        "lab": "City Hospital",
        "status": "Negative",
        "observations": "SARS-CoV-2 RNA not detected.",
        "patientInfo": {
          "name": "Aarav Sharma",
          "age": "28",
          "gender": "Male",
          "reportId": "L-998231",
        },
        "results": [
          {
            "param": "SARS-CoV-2 RNA",
            "value": "NOT DETECTED",
            "unit": "-",
            "reference": "-",
          },
          {"param": "Ct Value", "value": "N/A", "unit": "-", "reference": "-"},
        ],
      },
      {
        "title": "Lipid Profile",
        "date": "12 May 2025",
        "lab": "Precision Labs",
        "status": "Abnormal",
        "observations":
            "Slightly elevated LDL cholesterol. Dietary management advised.",
        "patientInfo": {
          "name": "Aarav Sharma",
          "age": "28",
          "gender": "Male",
          "reportId": "L-112345",
        },
        "results": [
          {
            "param": "Cholesterol, Total",
            "value": "210",
            "unit": "mg/dL",
            "reference": "< 200",
            "isAbnormal": true,
          },
          {
            "param": "Triglycerides",
            "value": "145",
            "unit": "mg/dL",
            "reference": "< 150",
          },
          {"param": "HDL", "value": "45", "unit": "mg/dL", "reference": "> 40"},
          {
            "param": "LDL",
            "value": "138",
            "unit": "mg/dL",
            "reference": "< 130",
            "isAbnormal": true,
          },
        ],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final r = reports[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.picture_as_pdf, color: Colors.teal),
            ),
            title: Text(
              r['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${r['date']} • ${r['lab']}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReportDetailScreen(reportData: r),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPrescriptionsTab() {
    final List<Map<String, dynamic>> docs = [
      {
        "doctor": "Dr. Sarita Sharma",
        "specialty": "Cardiologist",
        "date": "12 Dec 2025",
        "rxId": "RX-88231",
        "advice":
            "Lower salt intake and continue daily morning walks. Avoid stressful environments.",
        "medicines": [
          {
            "name": "Telmisartan 40mg",
            "dosage": "1 Tablet",
            "duration": "30 Days",
            "freq": "Daily",
            "time": "Morning",
          },
          {
            "name": "Atorvastatin 10mg",
            "dosage": "1 Tablet",
            "duration": "30 Days",
            "freq": "Daily",
            "time": "Night",
          },
          {
            "name": "Aspirin 75mg",
            "dosage": "1 Tablet",
            "duration": "15 Days",
            "freq": "Daily",
            "time": "Night",
          },
        ],
      },
      {
        "doctor": "Dr. Mukesh Chaudhary",
        "specialty": "Dermatologist",
        "date": "01 Nov 2025",
        "rxId": "RX-41105",
        "advice":
            "Apply ointment twice daily. Avoid direct sunlight for long durations.",
        "medicines": [
          {
            "name": "Clobetasol Propionate",
            "dosage": "Apply thin layer",
            "duration": "10 Days",
            "freq": "2 times",
            "time": "After Bath",
          },
          {
            "name": "Cetirizine 10mg",
            "dosage": "1 Tablet",
            "duration": "5 Days",
            "freq": "OD",
            "time": "Night",
          },
        ],
      },
      {
        "doctor": "Dr. Amrita Singh",
        "specialty": "General Physician",
        "date": "15 Sep 2025",
        "rxId": "RX-11092",
        "advice":
            "Soft diet recommended. Take plenty of rest and hydrate well.",
        "medicines": [
          {
            "name": "Amoxicillin 500mg",
            "dosage": "1 Capsule",
            "duration": "5 Days",
            "freq": "TID",
            "time": "Post Meal",
          },
          {
            "name": "Paracetamol 650mg",
            "dosage": "1 Tablet",
            "duration": "3 Days",
            "freq": "SOS",
            "time": "After Food",
          },
        ],
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final d = docs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: const Icon(Icons.person, color: Colors.blue),
            ),
            title: Text(
              d['doctor'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${d['specialty']} • ${d['date']}"),
            trailing: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PrescriptionDetailScreen(prescriptionData: d),
                  ),
                );
              },
              child: const Text("View"),
            ),
          ),
        );
      },
    );
  }

  Widget _vitalCard({
    required String title,
    required String value,
    required String unit,
    required String status,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  unit,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 9,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
