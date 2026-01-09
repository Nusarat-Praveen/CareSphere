import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'hospital_profile_screen.dart';

class HospitalMapScreen extends StatefulWidget {
  final List<Map<String, dynamic>> hospitals;

  const HospitalMapScreen({super.key, required this.hospitals});

  @override
  State<HospitalMapScreen> createState() => _HospitalMapScreenState();
}

class _HospitalMapScreenState extends State<HospitalMapScreen> {
  late GoogleMapController _mapController;
  Map<String, dynamic>? _selectedHospital;
  Set<Marker> _markers = {};

  // Default to Bangalore initially, but will update
  LatLng _center = const LatLng(12.9716, 77.5946);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _useDefaultLocation();
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _useDefaultLocation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _useDefaultLocation();
        return;
      }

      // Added timeout to prevent infinite loading
      Position position = await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 5),
      );

      if (!mounted) return;

      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _isLoading = false;
        _createMarkers(_center);
      });

      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _center, zoom: 14.0),
        ),
      );
    } catch (e) {
      debugPrint("Error getting location: $e");
      if (mounted) {
        _useDefaultLocation();
      }
    }
  }

  void _useDefaultLocation() {
    setState(() {
      _isLoading = false;
      _createMarkers(_center);
    });
  }

  void _createMarkers(LatLng centerPoint) {
    Set<Marker> newMarkers = {};
    for (int i = 0; i < widget.hospitals.length; i++) {
      final hospital = widget.hospitals[i];
      // Create a deterministic but scattered position AROUND the user
      // Using simple offsets
      final double latOffset = (i % 3 - 1) * 0.01 + (i * 0.002);
      final double lngOffset = (i % 4 - 1.5) * 0.01 - (i * 0.002);

      final LatLng position = LatLng(
        centerPoint.latitude + latOffset,
        centerPoint.longitude + lngOffset,
      );

      newMarkers.add(
        Marker(
          markerId: MarkerId('hospital_$i'),
          position: position,
          infoWindow: InfoWindow(
            title: hospital['name'],
            snippet: hospital['type'],
          ),
          onTap: () {
            setState(() {
              _selectedHospital = hospital;
            });
          },
        ),
      );
    }
    setState(() {
      _markers = newMarkers;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (!_isLoading) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _center, zoom: 14.0),
        ),
      );
    }
  }

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
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 13.0),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          if (_isLoading) const Center(child: CircularProgressIndicator()),

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
