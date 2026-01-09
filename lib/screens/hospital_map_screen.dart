import 'package:flutter/material.dart';
import 'hospital_profile_screen.dart';

class HospitalMapScreen extends StatefulWidget {
  final List<Map<String, dynamic>> hospitals;

  const HospitalMapScreen({super.key, required this.hospitals});

  @override
  State<HospitalMapScreen> createState() => _HospitalMapScreenState();
}

class _HospitalMapScreenState extends State<HospitalMapScreen> {
  Map<String, dynamic>? _selectedHospital;

  // Simulated coordinates (0.0 to 1.0) for markers
  final List<Offset> _markerPositions = [
    const Offset(0.25, 0.35),
    const Offset(0.55, 0.25),
    const Offset(0.75, 0.45),
    const Offset(0.35, 0.65),
    const Offset(0.65, 0.75),
    const Offset(0.15, 0.85),
    const Offset(0.8, 0.15),
    const Offset(0.4, 0.1),
    const Offset(0.9, 0.6),
    const Offset(0.1, 0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals Near You'),
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

          // Hospital Markers
          ...List.generate(
            widget.hospitals.length > _markerPositions.length
                ? _markerPositions.length
                : widget.hospitals.length,
            (index) {
              final pos = _markerPositions[index];
              final hospital = widget.hospitals[index];
              return Positioned(
                left: MediaQuery.of(context).size.width * pos.dx,
                top: MediaQuery.of(context).size.height * 0.7 * pos.dy,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedHospital = hospital;
                    });
                  },
                  child: AnimatedScale(
                    scale: _selectedHospital == hospital ? 1.2 : 1.0,
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
                              color: _selectedHospital == hospital
                                  ? Colors.indigo
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.indigo.shade50,
                            child: Icon(
                              hospital['image'] as IconData,
                              color: Colors.indigo,
                              size: 24,
                            ),
                          ),
                        ),
                        if (_selectedHospital == hospital)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              (hospital['name'] as String).split(' ').first,
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

          // Selected Hospital Card
          if (_selectedHospital != null)
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: _buildHospitalInfoCard(_selectedHospital!),
            ),
        ],
      ),
    );
  }

  Widget _buildSimulatedMap() {
    return CustomPaint(painter: MapPainter());
  }

  Widget _buildHospitalInfoCard(Map<String, dynamic> hospital) {
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
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              hospital['image'] as IconData,
              color: Colors.indigo,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  hospital['type'],
                  style: TextStyle(color: Colors.indigo.shade700, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      hospital['rating'].toString(),
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
              backgroundColor: Colors.indigo,
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
                  builder: (context) =>
                      HospitalProfileScreen(hospital: hospital),
                ),
              );
            },
            child: const Text('View'),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedHospital = null;
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
    path.moveTo(0, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.4);

    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.4, size.height);

    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.7,
      size.width,
      size.height * 0.9,
    );

    canvas.drawPath(path, roadPaint);

    // Draw some "buildings/parks"
    final parkPaint = Paint()
      ..color = Colors.green.shade100.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(40, 60, 80, 50), parkPaint);

    final buildingPaint = Paint()
      ..color = Colors.grey.shade400.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(size.width - 120, 150, 90, 70),
      buildingPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(80, size.height - 180, 60, 100),
      buildingPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
