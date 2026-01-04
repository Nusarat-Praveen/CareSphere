class DoctorAccount {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String specialization;
  final String licenseNumber;
  final String hospitalName;
  final int yearsOfExperience;
  final String? profileImage;
  final DateTime createdAt;

  DoctorAccount({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.licenseNumber,
    required this.hospitalName,
    required this.yearsOfExperience,
    this.profileImage,
    required this.createdAt,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'specialization': specialization,
      'licenseNumber': licenseNumber,
      'hospitalName': hospitalName,
      'yearsOfExperience': yearsOfExperience,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory DoctorAccount.fromJson(Map<String, dynamic> json) {
    return DoctorAccount(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      specialization: json['specialization'],
      licenseNumber: json['licenseNumber'],
      hospitalName: json['hospitalName'],
      yearsOfExperience: json['yearsOfExperience'],
      profileImage: json['profileImage'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
