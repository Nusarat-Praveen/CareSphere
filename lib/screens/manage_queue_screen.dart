import 'package:flutter/material.dart';

class ManageQueueScreen extends StatefulWidget {
  const ManageQueueScreen({super.key});

  @override
  State<ManageQueueScreen> createState() => _ManageQueueScreenState();
}

class _ManageQueueScreenState extends State<ManageQueueScreen> {
  String _sortBy = 'Token';

  final List<Map<String, dynamic>> _queue = [
    {
      'token': 'T-04',
      'name': 'Rajesh Kumar',
      'status': 'Waiting',
      'time': '10:30 AM',
      'type': 'Follow-up',
    },
    {
      'token': 'T-05',
      'name': 'Priya Sharma',
      'status': 'Arrived',
      'time': '10:45 AM',
      'type': 'New Patient',
    },
    {
      'token': 'T-06',
      'name': 'Amit Patel',
      'status': 'Waiting',
      'time': '11:00 AM',
      'type': 'Consulation',
    },
    {
      'token': 'T-07',
      'name': 'Sunita Desai',
      'status': 'Waiting',
      'time': '11:15 AM',
      'type': 'Report Review',
    },
    {
      'token': 'T-08',
      'name': 'Vikram Singh',
      'status': 'Waiting',
      'time': '11:30 AM',
      'type': 'Emergency',
    },
  ];

  void _sortQueue() {
    setState(() {
      if (_sortBy == 'Token') {
        _queue.sort((a, b) => a['token'].compareTo(b['token']));
      } else if (_sortBy == 'Name') {
        _queue.sort((a, b) => a['name'].compareTo(b['name']));
      } else if (_sortBy == 'Time') {
        // Simple string comparison for time as they are in same AM/PM format
        _queue.sort((a, b) => a['time'].compareTo(b['time']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Patient Queue'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Queue Summary Header
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.teal.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('In Queue', '5', Icons.people, Colors.teal),
                _buildSummaryItem(
                  'Arrived',
                  '1',
                  Icons.check_circle,
                  Colors.green,
                ),
                _buildSummaryItem(
                  'Est. Wait',
                  '45m',
                  Icons.timer,
                  Colors.orange,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Row(
              children: [
                const Text(
                  'Upcoming Patients',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    _sortBy = value;
                    _sortQueue();
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Token',
                      child: Text('Sort by Token'),
                    ),
                    const PopupMenuItem(
                      value: 'Name',
                      child: Text('Sort by Name'),
                    ),
                    const PopupMenuItem(
                      value: 'Time',
                      child: Text('Sort by Time'),
                    ),
                  ],
                  child: Row(
                    children: [
                      const Icon(Icons.sort, size: 20, color: Colors.teal),
                      const SizedBox(width: 4),
                      Text(
                        'By $_sortBy',
                        style: const TextStyle(
                          color: Colors.teal,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Queue List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _queue.length,
              itemBuilder: (context, index) {
                final patient = _queue[index];
                return _buildQueueItem(patient, index);
              },
            ),
          ),

          // Bottom Action
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Starting next consultation...'),
                  ),
                );
              },
              icon: const Icon(Icons.play_circle_filled, size: 28),
              label: const Text(
                'CALL NEXT PATIENT',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> patient, int index) {
    final bool isNext = index == 0;
    final bool hasArrived = patient['status'] == 'Arrived';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isNext ? Border.all(color: Colors.teal, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isNext ? Colors.teal : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    patient['token'],
                    style: TextStyle(
                      color: isNext ? Colors.white : Colors.teal.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          patient['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isNext)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'NEXT',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${patient['type']} • ${patient['time']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: hasArrived
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  patient['status'],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: hasArrived ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      patient['status'] = hasArrived ? 'Waiting' : 'Arrived';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: hasArrived ? Colors.grey : Colors.green,
                    side: BorderSide(
                      color: hasArrived ? Colors.grey.shade300 : Colors.green,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(hasArrived ? 'Mark Waiting' : 'Mark Arrived'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Patient ${patient['name']} skipped'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Skip'),
                ),
              ),
              if (isNext) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Starting consultation...'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Start'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
