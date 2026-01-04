import 'package:flutter/material.dart';
import 'appointment_detail_screen.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: handled by theme
        appBar: AppBar(
          title: const Text('My Appointments'),
          centerTitle: true,
          // titleTextStyle: handled by theme
          // iconTheme: handled by theme
          bottom: const TabBar(
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.teal,
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Past"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUpcomingAppointments(context),
            _buildPastAppointments(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildAppointmentCard(
          context,
          doctorName: "Dr. Anjali Sharma",
          speciality: "Cardiologist",
          date: "Tomorrow",
          time: "10:00 AM",
          status: "Confirmed",
          statusColor: Colors.green,
          actionButton: "Reschedule",
        ),
        _buildAppointmentCard(
          context,
          doctorName: "Dr. Rahul Verma",
          speciality: "Dermatologist",
          date: "Dec 30, 2024",
          time: "02:00 PM",
          status: "Pending",
          statusColor: Colors.orange,
          actionButton: "Cancel",
        ),
      ],
    );
  }

  Widget _buildPastAppointments(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildAppointmentCard(
          context,
          doctorName: "Dr. Sneha Patel",
          speciality: "Pediatrician",
          date: "Dec 15, 2024",
          time: "11:00 AM",
          status: "Completed",
          statusColor: Colors.grey,
          isPast: true,
        ),
        _buildAppointmentCard(
          context,
          doctorName: "Dr. Deepak Lamba",
          speciality: "Dentist",
          date: "Nov 28, 2024",
          time: "05:00 PM",
          status: "Completed",
          statusColor: Colors.grey,
          isPast: true,
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context, {
    required String doctorName,
    required String speciality,
    required String date,
    required String time,
    required String status,
    required Color statusColor,
    String? actionButton,
    bool isPast = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          final dummyMember = {
            'name': 'Rajesh Kumar',
            'relationship': 'Me',
            'age': '34',
            'gender': 'Male',
            'image': Icons.person,
            'bloodGroup': 'A+',
            'healthStatus': 'Healthy',
            'lastCheckup': '15 Dec 2025',
          };
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentDetailScreen(
                member: dummyMember,
                appointmentTitle: 'Doctor Consultation',
                isPast: isPast,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.teal.shade100,
                    child: const Icon(
                      Icons.person,
                      color: Colors.teal,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          speciality,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (actionButton != null)
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        actionButton,
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
