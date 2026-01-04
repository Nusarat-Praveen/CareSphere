import 'package:flutter/material.dart';

class DoctorScheduleScreen extends StatefulWidget {
  const DoctorScheduleScreen({super.key});

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  DateTime _selectedDate = DateTime.now();

  void _previousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(date.year, date.month, date.day);

    if (selectedDay == today) {
      return 'Today';
    } else if (selectedDay == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (selectedDay == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    }
    return '';
  }

  // Get appointments for the selected date
  Map<String, List<Map<String, dynamic>>> _getAppointmentsForDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final dayDifference = selectedDay.difference(today).inDays;

    // Different appointments for different days
    if (dayDifference == 0) {
      // Today's appointments
      return {
        'morning': [
          {
            'time': '9:00 AM - 9:30 AM',
            'patient': 'Rajesh Kumar',
            'reason': 'Regular Checkup',
            'booked': true,
          },
          {
            'time': '10:00 AM - 10:30 AM',
            'patient': 'Priya Sharma',
            'reason': 'Follow-up Consultation',
            'booked': true,
          },
          {
            'time': '11:00 AM - 11:30 AM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
        ],
        'afternoon': [
          {
            'time': '2:00 PM - 2:30 PM',
            'patient': 'Amit Patel',
            'reason': 'New Patient Consultation',
            'booked': true,
          },
          {
            'time': '3:00 PM - 3:30 PM',
            'patient': 'Sunita Desai',
            'reason': 'Prescription Renewal',
            'booked': true,
          },
          {
            'time': '4:00 PM - 4:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
        ],
        'evening': [
          {
            'time': '6:00 PM - 6:30 PM',
            'patient': 'Vikram Singh',
            'reason': 'Emergency Consultation',
            'booked': true,
          },
          {
            'time': '7:00 PM - 7:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
        ],
      };
    } else if (dayDifference == 1) {
      // Tomorrow's appointments
      return {
        'morning': [
          {
            'time': '9:00 AM - 9:30 AM',
            'patient': 'Meera Kapoor',
            'reason': 'Annual Checkup',
            'booked': true,
          },
          {
            'time': '10:00 AM - 10:30 AM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '11:00 AM - 11:30 AM',
            'patient': 'Ravi Gupta',
            'reason': 'Blood Pressure Monitoring',
            'booked': true,
          },
        ],
        'afternoon': [
          {
            'time': '2:00 PM - 2:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '3:00 PM - 3:30 PM',
            'patient': 'Anjali Verma',
            'reason': 'Diabetes Follow-up',
            'booked': true,
          },
          {
            'time': '4:00 PM - 4:30 PM',
            'patient': 'Karan Mehta',
            'reason': 'General Consultation',
            'booked': true,
          },
        ],
        'evening': [
          {
            'time': '6:00 PM - 6:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '7:00 PM - 7:30 PM',
            'patient': 'Pooja Nair',
            'reason': 'Prescription Review',
            'booked': true,
          },
        ],
      };
    } else if (dayDifference == -1) {
      // Yesterday's appointments
      return {
        'morning': [
          {
            'time': '9:00 AM - 9:30 AM',
            'patient': 'Sanjay Rao',
            'reason': 'Post-surgery Checkup',
            'booked': true,
          },
          {
            'time': '10:00 AM - 10:30 AM',
            'patient': 'Lakshmi Iyer',
            'reason': 'Routine Examination',
            'booked': true,
          },
          {
            'time': '11:00 AM - 11:30 AM',
            'patient': 'Deepak Joshi',
            'reason': 'Heart Health Review',
            'booked': true,
          },
        ],
        'afternoon': [
          {
            'time': '2:00 PM - 2:30 PM',
            'patient': 'Neha Agarwal',
            'reason': 'Allergy Consultation',
            'booked': true,
          },
          {
            'time': '3:00 PM - 3:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '4:00 PM - 4:30 PM',
            'patient': 'Rahul Saxena',
            'reason': 'Follow-up Visit',
            'booked': true,
          },
        ],
        'evening': [
          {
            'time': '6:00 PM - 6:30 PM',
            'patient': 'Kavita Sharma',
            'reason': 'New Patient',
            'booked': true,
          },
          {
            'time': '7:00 PM - 7:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
        ],
      };
    } else {
      // Other days - lighter schedule
      return {
        'morning': [
          {
            'time': '9:00 AM - 9:30 AM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '10:00 AM - 10:30 AM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '11:00 AM - 11:30 AM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
        ],
        'afternoon': [
          {
            'time': '2:00 PM - 2:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '3:00 PM - 3:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '4:00 PM - 4:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
        ],
        'evening': [
          {
            'time': '6:00 PM - 6:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
          {
            'time': '7:00 PM - 7:30 PM',
            'patient': 'Available',
            'reason': 'No appointment',
            'booked': false,
          },
        ],
      };
    }
  }

  void _showAppointmentOptions(
    BuildContext context,
    String patientName,
    String time,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              patientName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              time,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            _buildOptionTile(
              context,
              Icons.info_outline,
              'View Details',
              Colors.blue,
              () {
                Navigator.pop(context);
                _showAppointmentDetails(context, patientName, time);
              },
            ),
            _buildOptionTile(
              context,
              Icons.edit_calendar,
              'Reschedule',
              Colors.orange,
              () {
                Navigator.pop(context);
                _showRescheduleDialog(context, patientName, time);
              },
            ),
            _buildOptionTile(
              context,
              Icons.cancel_outlined,
              'Cancel Appointment',
              Colors.red,
              () {
                Navigator.pop(context);
                _showCancelConfirmation(context, patientName);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showAppointmentDetails(
    BuildContext context,
    String patientName,
    String time,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue),
            const SizedBox(width: 12),
            const Text('Appointment Details'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Patient Name', patientName, Icons.person),
              const SizedBox(height: 12),
              _buildDetailRow('Time', time, Icons.access_time),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Date',
                _formatDate(_selectedDate),
                Icons.calendar_today,
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Status',
                'Confirmed',
                Icons.check_circle,
                Colors.green,
              ),
              const SizedBox(height: 12),
              _buildDetailRow('Type', 'In-person', Icons.location_on),
              const SizedBox(height: 12),
              _buildDetailRow('Contact', '+91 98765 43210', Icons.phone),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.notes,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Patient has requested consultation for regular health checkup',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Starting consultation...')),
              );
            },
            icon: const Icon(Icons.video_call),
            label: const Text('Start Consultation'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon, [
    Color? color,
  ]) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color ?? Theme.of(context).hintColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).hintColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showRescheduleDialog(
    BuildContext context,
    String patientName,
    String currentTime,
  ) {
    String? selectedDate;
    String? selectedTime;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.edit_calendar, color: Colors.orange),
              const SizedBox(width: 12),
              const Text('Reschedule Appointment'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patient: $patientName',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Current: $currentTime',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select New Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  hint: const Text('Choose date'),
                  value: selectedDate,
                  items:
                      [
                        'Tomorrow',
                        'Day After Tomorrow',
                        'Next Week',
                        'Custom Date',
                      ].map((date) {
                        return DropdownMenuItem(value: date, child: Text(date));
                      }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedDate = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select New Time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  hint: const Text('Choose time'),
                  value: selectedTime,
                  items:
                      [
                        '9:00 AM',
                        '10:00 AM',
                        '11:00 AM',
                        '2:00 PM',
                        '3:00 PM',
                        '4:00 PM',
                        '6:00 PM',
                        '7:00 PM',
                      ].map((time) {
                        return DropdownMenuItem(value: time, child: Text(time));
                      }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedTime = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: selectedDate != null && selectedTime != null
                  ? () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Appointment rescheduled to $selectedDate at $selectedTime',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Reschedule'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context, String patientName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: Text(
          'Are you sure you want to cancel the appointment with $patientName?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Appointment with $patientName cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _showBlockTimeDialog() {
    final timeController = TextEditingController();
    final durationController = TextEditingController();
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block Time Slot'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time Slot',
                  hintText: 'e.g., 2:00 PM - 3:00 PM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration',
                  hintText: 'e.g., 1 hour',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timelapse),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Reason (Optional)',
                  hintText: 'e.g., Lunch break, Meeting',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (timeController.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Time slot blocked: ${timeController.text}'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text('Block Time'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedule'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _previousDay,
                    icon: const Icon(Icons.chevron_left),
                    tooltip: 'Previous Day',
                  ),
                  Column(
                    children: [
                      Text(
                        _getDateLabel(_selectedDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(_selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _nextDay,
                    icon: const Icon(Icons.chevron_right),
                    tooltip: 'Next Day',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Morning Appointments
            const Text(
              'Morning (9:00 AM - 12:00 PM)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...(_getAppointmentsForDate()['morning'] ?? []).map((appointment) {
              return _buildAppointmentSlot(
                context,
                appointment['time'] as String,
                appointment['patient'] as String,
                appointment['reason'] as String,
                appointment['booked'] as bool,
              );
            }).toList(),

            const SizedBox(height: 24),

            // Afternoon Appointments
            const Text(
              'Afternoon (2:00 PM - 5:00 PM)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...(_getAppointmentsForDate()['afternoon'] ?? []).map((
              appointment,
            ) {
              return _buildAppointmentSlot(
                context,
                appointment['time'] as String,
                appointment['patient'] as String,
                appointment['reason'] as String,
                appointment['booked'] as bool,
              );
            }).toList(),

            const SizedBox(height: 24),

            // Evening Appointments
            const Text(
              'Evening (6:00 PM - 8:00 PM)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...(_getAppointmentsForDate()['evening'] ?? []).map((appointment) {
              return _buildAppointmentSlot(
                context,
                appointment['time'] as String,
                appointment['patient'] as String,
                appointment['reason'] as String,
                appointment['booked'] as bool,
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showBlockTimeDialog,
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Block Time', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildAppointmentSlot(
    BuildContext context,
    String time,
    String patientName,
    String reason,
    bool isBooked,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isBooked
            ? Theme.of(context).cardColor
            : Theme.of(context).disabledColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isBooked
              ? Colors.teal.withOpacity(0.3)
              : Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            decoration: BoxDecoration(
              color: isBooked ? Colors.teal : Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isBooked ? Colors.teal : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  patientName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isBooked ? FontWeight.bold : FontWeight.normal,
                    color: isBooked ? null : Theme.of(context).disabledColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  reason,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          if (isBooked)
            IconButton(
              onPressed: () =>
                  _showAppointmentOptions(context, patientName, time),
              icon: const Icon(Icons.more_vert),
              color: Colors.grey,
              tooltip: 'Options',
            ),
        ],
      ),
    );
  }
}
