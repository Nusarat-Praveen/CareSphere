import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';

class DoctorCategoryDetailScreen extends StatefulWidget {
  final String specialtyName;
  final List<Map<String, dynamic>> doctors;
  final IconData icon;
  final Color color;

  const DoctorCategoryDetailScreen({
    super.key,
    required this.specialtyName,
    required this.doctors,
    required this.icon,
    required this.color,
  });

  @override
  State<DoctorCategoryDetailScreen> createState() =>
      _DoctorCategoryDetailScreenState();
}

class _DoctorCategoryDetailScreenState
    extends State<DoctorCategoryDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _filteredDoctors;

  @override
  void initState() {
    super.initState();
    _filteredDoctors = widget.doctors;
    _searchController.addListener(_filterDoctors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDoctors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDoctors = widget.doctors.where((doctor) {
        return doctor['name'].toLowerCase().contains(query) ||
            doctor['location'].toLowerCase().contains(query);
      }).toList();
    });
  }

  String _getSpecialtyTip() {
    switch (widget.specialtyName) {
      case "Cardiologist":
        return "Regular heart check-ups can prevent serious conditions. Maintain a healthy lifestyle with exercise and balanced diet.";
      case "Dermatologist":
        return "Protect your skin from sun damage. Use sunscreen daily and stay hydrated for healthy skin.";
      case "Pediatrician":
        return "Keep your child's vaccination schedule up to date. Regular check-ups ensure healthy growth and development.";
      case "Orthopedic Surgeon":
        return "Maintain good posture and stay active. Early treatment of bone and joint issues prevents long-term complications.";
      case "Neurologist":
        return "Brain health is vital. Seek immediate help for persistent headaches, memory issues, or neurological symptoms.";
      case "Dentist":
        return "Brush twice daily and floss regularly. Visit your dentist every 6 months for optimal oral health.";
      case "Gynecologist":
        return "Regular gynecological check-ups are essential for women's health. Don't delay prenatal care during pregnancy.";
      case "Oncologist":
        return "Early cancer detection saves lives. Regular screenings and healthy lifestyle reduce cancer risk significantly.";
      case "Ophthalmologist":
        return "Regular eye exams can detect vision problems early. Protect your eyes from strain and UV damage.";
      case "Gastroenterologist":
        return "Digestive health affects overall well-being. Maintain a fiber-rich diet and stay hydrated.";
      case "Psychiatrist":
        return "Mental health is as important as physical health. Don't hesitate to seek professional support when needed.";
      case "Urologist":
        return "Stay hydrated and maintain urinary health. Don't ignore symptoms like pain or difficulty urinating.";
      case "Endocrinologist":
        return "Hormonal balance is crucial. Regular monitoring of thyroid and diabetes helps prevent complications.";
      case "Pulmonologist":
        return "Lung health is vital. Avoid smoking and seek help for persistent cough or breathing difficulties.";
      case "Rheumatologist":
        return "Joint pain shouldn't be ignored. Early treatment of arthritis and autoimmune conditions improves quality of life.";
      case "Nephrologist":
        return "Kidney health is essential. Stay hydrated, control blood pressure, and monitor kidney function regularly.";
      case "Neurosurgeon":
        return "Brain and spine health require expert care. Don't delay treatment for neurological conditions.";
      case "Radiologist":
        return "Accurate diagnosis is the first step to treatment. Advanced imaging helps detect conditions early.";
      case "ENT Specialist":
        return "Ear, nose, and throat health affects quality of life. Seek help for persistent symptoms.";
      case "General Surgeon":
        return "Timely surgical intervention can be life-saving. Consult experienced surgeons for the best outcomes.";
      default:
        return "Quality healthcare is your right. Choose experienced specialists for the best medical care.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.specialtyName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.color.withOpacity(0.8), widget.color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Health Tip Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb, color: widget.color),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Health Tip",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: widget.color,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getSpecialtyTip(),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search Bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search ${widget.specialtyName}s...',
                      prefixIcon: Icon(Icons.search, color: widget.color),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: widget.color, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All ${widget.specialtyName}s",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${_filteredDoctors.length} found",
                          style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _filteredDoctors.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No doctors found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final doctor = _filteredDoctors[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: _buildDoctorCard(doctor),
                    );
                  }, childCount: _filteredDoctors.length),
                ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
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
              backgroundColor: widget.color.withOpacity(0.1),
              child: Icon(Icons.person, size: 32, color: widget.color),
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
                    style: TextStyle(
                      color: widget.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Experience: ${doctor['experience']}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
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
                backgroundColor: widget.color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
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
