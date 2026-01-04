import 'package:flutter/material.dart';
import 'family_member_detail_screen.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final familyMembers = [
      {
        'name': 'Rajesh Kumar',
        'relationship': 'Me',
        'age': '34',
        'gender': 'Male',
        'image': Icons.person,
        'bloodGroup': 'A+',
        'healthStatus': 'Healthy',
        'lastCheckup': '15 Dec 2025',
      },
      {
        'name': 'Priya Devi',
        'relationship': 'Wife',
        'age': '31',
        'gender': 'Female',
        'image': Icons.woman,
        'bloodGroup': 'B+',
        'healthStatus': 'Monitoring',
        'lastCheckup': '20 Nov 2025',
      },
      {
        'name': 'Aarav Kumar',
        'relationship': 'Son',
        'age': '6',
        'gender': 'Male',
        'image': Icons.child_care,
        'bloodGroup': 'A+',
        'healthStatus': 'Healthy',
        'lastCheckup': '10 Dec 2025',
      },
      {
        'name': 'Sushila Devi',
        'relationship': 'Mother',
        'age': '58',
        'gender': 'Female',
        'image': Icons.elderly,
        'bloodGroup': 'O+',
        'healthStatus': 'Follow-up',
        'lastCheckup': '05 Dec 2025',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Family'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline, color: Colors.teal),
            tooltip: 'Add Family Member',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: familyMembers.length + 1,
        itemBuilder: (context, index) {
          if (index == familyMembers.length) {
            return _buildAddMemberButton(context);
          }
          final member = familyMembers[index];
          return _buildMemberCard(context, member);
        },
      ),
    );
  }

  Widget _buildMemberCard(BuildContext context, Map<String, dynamic> member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 12, 5),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal.shade50,
                  child: Icon(
                    member['image'] as IconData,
                    size: 32,
                    color: Colors.teal,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: member['healthStatus'] == 'Healthy'
                            ? Colors.green
                            : (member['healthStatus'] == 'Monitoring'
                                  ? Colors.orange
                                  : Colors.red),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              member['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                '${member['relationship']} • ${member['age']} years • ${member['gender']}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FamilyMemberDetailScreen(member: member),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoBadge(
                  context,
                  Icons.bloodtype,
                  member['bloodGroup'],
                  Colors.red.shade50,
                  Colors.red,
                ),
                _buildInfoBadge(
                  context,
                  Icons.health_and_safety,
                  member['healthStatus'],
                  Colors.teal.shade50,
                  Colors.teal,
                ),
                _buildInfoBadge(
                  context,
                  Icons.event,
                  member['lastCheckup']
                      .toString()
                      .split(' ')
                      .sublist(0, 2)
                      .join(' '),
                  Colors.blue.shade50,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(
    BuildContext context,
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: iconColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal.withOpacity(0.3), width: 1.5),
          borderRadius: BorderRadius.circular(20),
          color: Colors.teal.withOpacity(0.02),
        ),
        child: const Column(
          children: [
            Icon(Icons.add, color: Colors.teal, size: 30),
            SizedBox(height: 8),
            Text(
              'Add Family Member',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
