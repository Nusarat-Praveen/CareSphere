import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';

class DoctorMapScreen extends StatefulWidget {
  final List<Map<String, dynamic>> doctors;

  const DoctorMapScreen({super.key, required this.doctors});

  @override
  State<DoctorMapScreen> createState() => _DoctorMapScreenState();
}

class _DoctorMapScreenState extends State<DoctorMapScreen> {
  Map<String, dynamic>? _selectedDoctor;

  // Simulated coordinates (0.0 to 1.0) for markers
  final List<Offset> _markerPositions = [
    const Offset(0.2, 0.3),
    const Offset(0.5, 0.2),
    const Offset(0.8, 0.4),
    const Offset(0.3, 0.6),
    const Offset(0.6, 0.7),
    const Offset(0.1, 0.8),
    const Offset(0.85, 0.75),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors Near You'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.list),
            tooltip: 'List View',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Simulated Map Background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade200,
            child: _buildSimulatedMap(),
          ),

          // Doctor Markers
          ...List.generate(
            widget.doctors.length > _markerPositions.length
                ? _markerPositions.length
                : widget.doctors.length,
            (index) {
              final pos = _markerPositions[index];
              final doctor = widget.doctors[index];
              return Positioned(
                left: MediaQuery.of(context).size.width * pos.dx,
                top: MediaQuery.of(context).size.height * 0.7 * pos.dy,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDoctor = doctor;
                    });
                  },
                  child: AnimatedScale(
                    scale: _selectedDoctor == doctor ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                              color: _selectedDoctor == doctor
                                  ? Colors.teal
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.teal.shade50,
                            child: const Icon(
                              Icons.person,
                              color: Colors.teal,
                              size: 24,
                            ),
                          ),
                        ),
                        if (_selectedDoctor == doctor)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              doctor['name'].split(' ').last,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // User Location Marker (Static)
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Selected Doctor Card (Bottom Sheet style)
          if (_selectedDoctor != null)
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: _buildDoctorInfoCard(_selectedDoctor!),
            ),
        ],
      ),
    );
  }

  Widget _buildSimulatedMap() {
    return CustomPaint(painter: MapPainter());
  }

  Widget _buildDoctorInfoCard(Map<String, dynamic> doctor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.teal.shade50,
            child: const Icon(Icons.person, color: Colors.teal, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  doctor['speciality'],
                  style: TextStyle(color: Colors.teal.shade700, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      doctor['rating'].toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDoctor = null;
              });
            },
            icon: const Icon(Icons.close, size: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw some simulated "roads"
    final roadPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.5);

    path.moveTo(size.width * 0.3, 0);
    path.lineTo(size.width * 0.4, size.height);

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.6,
      size.width,
      size.height * 0.8,
    );

    canvas.drawPath(path, roadPaint);

    // Draw some "buildings"
    final buildingPaint = Paint()
      ..color = Colors.grey.shade400.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(20, 40, 60, 40), buildingPaint);
    canvas.drawRect(
      Rect.fromLTWH(size.width - 100, 100, 80, 60),
      buildingPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(60, size.height - 150, 70, 90),
      buildingPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.6, size.height * 0.4, 40, 40),
      buildingPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
