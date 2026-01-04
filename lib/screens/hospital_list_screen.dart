import 'package:flutter/material.dart';
import 'hospital_profile_screen.dart';
import 'hospital_map_screen.dart';
import 'hospital_category_detail_screen.dart';

class HospitalListScreen extends StatefulWidget {
  const HospitalListScreen({super.key});

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _allHospitals = [
    {
      'name': 'City Heart Hospital',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Worli, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'City Heart Hospital is a leading multispeciality hospital offering world-class healthcare services. We specialize in cardiac care, orthopedics, and neurosurgery.',
      'facilities': ['24/7 Emergency', 'MRI/CT Scan', 'ICU', 'Pharmacy'],
      'phone': '+91 22 1234 5678',
    },
    {
      'name': 'Global Eye Care',
      'type': 'Eye Specialist',
      'rating': 4.6,
      'location': 'Andheri, Mumbai',
      'image': Icons.visibility,
      'about':
          'Global Eye Care provides comprehensive eye treatments including Lasik, Cataract surgery, and pediatric ophthalmology with state-of-the-art technology.',
      'facilities': ['Optical Shop', 'Advanced Lasik', 'Emergency Eye Care'],
      'phone': '+91 22 2345 6789',
    },
    {
      'name': 'Happy Kids Clinic',
      'type': 'Pediatric Clinic',
      'rating': 4.7,
      'location': 'Bandra, Mumbai',
      'image': Icons.child_care,
      'about':
          'A child-friendly environment dedicated to the health and well-being of infants, children, and adolescents.',
      'facilities': ['Vaccination', 'Pediatric ICU', 'Play Area'],
      'phone': '+91 22 3456 7890',
    },
    {
      'name': 'Metro Dental Hub',
      'type': 'Dental Care',
      'rating': 4.5,
      'location': 'Colaba, Mumbai',
      'image': Icons.medical_services,
      'about':
          'The one-stop destination for all your dental needs, from routine check-ups to advanced cosmetic dentistry.',
      'facilities': ['Implants', 'Orthodontics', 'X-Ray'],
      'phone': '+91 22 4567 8901',
    },
    {
      'name': 'Sunrise Ortho Center',
      'type': 'Orthocare',
      'rating': 4.9,
      'location': 'Borivali, Mumbai',
      'image': Icons.accessibility_new,
      'about':
          'Specialized center for joint replacement, sports injuries, and spinal surgeries.',
      'facilities': ['Physiotherapy', 'Joint Replacement', 'Sports Medicine'],
      'phone': '+91 22 5678 9012',
    },
    {
      'name': 'Apex Neuro Center',
      'type': 'Neurology',
      'rating': 4.9,
      'location': 'Powai, Mumbai',
      'image': Icons.psychology,
      'about':
          'Apex Neuro Center provides comprehensive treatment for neurological disorders, including epilepsy, stroke, and Parkinson\'s disease.',
      'facilities': [
        'EEG/EMG',
        'Neuro Lab',
        '24/7 Stroke Care',
        'Rehabilitation',
      ],
      'phone': '+91 22 6789 0123',
    },
    {
      'name': 'HeartCare Institute',
      'type': 'Cardiology',
      'rating': 4.8,
      'location': 'Dadar, Mumbai',
      'image': Icons.favorite,
      'about':
          'A premier cardiology center dedicated to advanced cardiac treatments, heart surgeries, and preventive care.',
      'facilities': ['Cath Lab', 'Cardiac ICU', 'Echo & Stress Test'],
      'phone': '+91 22 7890 1234',
    },
    {
      'name': 'Skin & Aesthetic Clinic',
      'type': 'Dermatology',
      'rating': 4.7,
      'location': 'Juhu, Mumbai',
      'image': Icons.face,
      'about':
          'Expert dermatological care for skin, hair, and nail conditions, along with advanced aesthetic treatments.',
      'facilities': [
        'Laser Therapy',
        'Cosmetic Surgery',
        'Skin Allergy Testing',
      ],
      'phone': '+91 22 8901 2345',
    },
    {
      'name': 'MindWell Wellness Center',
      'type': 'Mental Health',
      'rating': 4.6,
      'location': 'Khar, Mumbai',
      'image': Icons.spa,
      'about':
          'Providing compassionate mental health support, counseling, and psychiatric care for all age groups.',
      'facilities': ['Counseling Rooms', 'Yoga & Meditation', 'Group Therapy'],
      'phone': '+91 22 9012 3456',
    },
    {
      'name': 'Unity General Hospital',
      'type': 'Multispeciality',
      'rating': 4.5,
      'location': 'Thane, Mumbai',
      'image': Icons.business,
      'about':
          'A trusted multispeciality hospital providing affordable and quality healthcare services to the community.',
      'facilities': ['General Ward', 'Maternity Care', 'Dialysis Center'],
      'phone': '+91 22 0123 4567',
    },
    // New Hospitals
    {
      'name': 'Apollo Specialty Hospital',
      'type': 'Multispeciality',
      'rating': 4.9,
      'location': 'Koramangala, Bangalore',
      'image': Icons.local_hospital,
      'about':
          'Apollo Specialty Hospital offers comprehensive healthcare with cutting-edge technology and expert medical professionals across all specialties.',
      'facilities': [
        'Robotic Surgery',
        'Transplant Unit',
        'Cancer Center',
        'Blood Bank',
      ],
      'phone': '+91 80 1234 5678',
    },
    {
      'name': 'Fortis Cancer Institute',
      'type': 'Oncology',
      'rating': 4.8,
      'location': 'Vasant Kunj, Delhi',
      'image': Icons.healing,
      'about':
          'Leading cancer treatment center with advanced radiation therapy, chemotherapy, and immunotherapy facilities.',
      'facilities': [
        'PET-CT Scan',
        'Radiation Therapy',
        'Oncology ICU',
        'Palliative Care',
      ],
      'phone': '+91 11 2345 6789',
    },
    {
      'name': 'Max Super Specialty',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Saket, Delhi',
      'image': Icons.local_hospital,
      'about':
          'Max Super Specialty Hospital is renowned for excellence in cardiac sciences, neurosciences, and minimal access surgery.',
      'facilities': ['Hybrid OT', 'Neonatal ICU', 'Trauma Center', 'Sleep Lab'],
      'phone': '+91 11 3456 7890',
    },
    {
      'name': 'Narayana Hrudayalaya',
      'type': 'Cardiology',
      'rating': 4.9,
      'location': 'Bommasandra, Bangalore',
      'image': Icons.favorite,
      'about':
          'Asia\'s largest cardiac care hospital performing thousands of heart surgeries annually with exceptional success rates.',
      'facilities': [
        'Cardiac Cath Lab',
        'ECMO',
        'Pediatric Cardiology',
        'Heart Transplant',
      ],
      'phone': '+91 80 4567 8901',
    },
    {
      'name': 'Sankara Eye Hospital',
      'type': 'Eye Specialist',
      'rating': 4.8,
      'location': 'Pammal, Chennai',
      'image': Icons.visibility,
      'about':
          'Dedicated eye care hospital providing free and affordable treatment for cataract, glaucoma, and retinal disorders.',
      'facilities': [
        'Cornea Bank',
        'Retina Clinic',
        'Pediatric Ophthalmology',
        'Low Vision Aid',
      ],
      'phone': '+91 44 5678 9012',
    },
    {
      'name': 'Manipal Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'HAL Airport Road, Bangalore',
      'image': Icons.local_hospital,
      'about':
          'Manipal Hospital delivers tertiary care with expertise in organ transplants, neurosciences, and orthopedics.',
      'facilities': [
        'Liver Transplant',
        'Bone Marrow Transplant',
        'Robotic Surgery',
        'Fertility Clinic',
      ],
      'phone': '+91 80 6789 0123',
    },
    {
      'name': 'Cloudnine Maternity',
      'type': 'Maternity',
      'rating': 4.6,
      'location': 'Jayanagar, Bangalore',
      'image': Icons.pregnant_woman,
      'about':
          'Premier maternity and childcare hospital offering personalized care for mothers and newborns.',
      'facilities': [
        'Labor Suites',
        'NICU Level 3',
        'Lactation Support',
        'Prenatal Classes',
      ],
      'phone': '+91 80 7890 1234',
    },
    {
      'name': 'AIIMS Trauma Center',
      'type': 'Emergency Care',
      'rating': 4.9,
      'location': 'Ansari Nagar, Delhi',
      'image': Icons.emergency,
      'about':
          'State-of-the-art trauma center providing 24/7 emergency services for critical injuries and accidents.',
      'facilities': [
        'Trauma ICU',
        'Burn Unit',
        'Poison Control',
        'Air Ambulance',
      ],
      'phone': '+91 11 8901 2345',
    },
    {
      'name': 'Medanta The Medicity',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Sector 38, Gurgaon',
      'image': Icons.local_hospital,
      'about':
          'One of India\'s largest multi-super specialty institutes with 45+ specialties under one roof.',
      'facilities': [
        'Robotic Surgery',
        'Organ Transplant',
        'Genomics Lab',
        'Rehabilitation Center',
      ],
      'phone': '+91 124 9012 3456',
    },
    {
      'name': 'Lilavati Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Bandra West, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Premium multispecialty hospital known for excellence in critical care, cardiac sciences, and organ transplants.',
      'facilities': [
        'Kidney Transplant',
        'Liver Transplant',
        'Advanced ICU',
        'Nuclear Medicine',
      ],
      'phone': '+91 22 0123 4567',
    },
    {
      'name': 'Aster CMI Hospital',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Hebbal, Bangalore',
      'image': Icons.local_hospital,
      'about':
          'Quaternary care hospital with advanced facilities in oncology, neurosciences, and cardiac sciences.',
      'facilities': [
        'Cyberknife',
        'Da Vinci Robot',
        'Bone Marrow Transplant',
        'Stroke Unit',
      ],
      'phone': '+91 80 1234 5678',
    },
    {
      'name': 'Kokilaben Dhirubhai Ambani',
      'type': 'Multispeciality',
      'rating': 4.9,
      'location': 'Andheri West, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Ultra-modern hospital with world-class infrastructure and expertise across all medical specialties.',
      'facilities': [
        'PET-CT',
        'Gamma Knife',
        'Transplant Center',
        'Robotic Surgery',
      ],
      'phone': '+91 22 2345 6789',
    },
    {
      'name': 'Rainbow Children Hospital',
      'type': 'Pediatric Clinic',
      'rating': 4.7,
      'location': 'Marathahalli, Bangalore',
      'image': Icons.child_care,
      'about':
          'India\'s leading pediatric multi-specialty hospital chain dedicated exclusively to children\'s healthcare.',
      'facilities': [
        'Pediatric ICU',
        'Neonatal Surgery',
        'Child Psychology',
        'Vaccination Center',
      ],
      'phone': '+91 80 3456 7890',
    },
    {
      'name': 'Jaslok Hospital',
      'type': 'Multispeciality',
      'rating': 4.6,
      'location': 'Pedder Road, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Historic multi-specialty hospital providing comprehensive healthcare with a legacy of trust and excellence.',
      'facilities': [
        'Dialysis Unit',
        'Endoscopy Center',
        'Pain Clinic',
        'Sleep Disorders Center',
      ],
      'phone': '+91 22 4567 8901',
    },
    {
      'name': 'Columbia Asia Hospital',
      'type': 'Multispeciality',
      'rating': 4.5,
      'location': 'Whitefield, Bangalore',
      'image': Icons.local_hospital,
      'about':
          'International standard healthcare facility offering quality medical services with personalized care.',
      'facilities': [
        'Day Care Surgery',
        'Health Check Packages',
        'Physiotherapy',
        'Dental Clinic',
      ],
      'phone': '+91 80 5678 9012',
    },
    {
      'name': 'Sir Ganga Ram Hospital',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Rajinder Nagar, Delhi',
      'image': Icons.local_hospital,
      'about':
          'Premier hospital known for excellence in nephrology, urology, gastroenterology, and kidney transplants.',
      'facilities': [
        'Kidney Transplant',
        'Lithotripsy',
        'Endoscopy',
        'Dialysis Center',
      ],
      'phone': '+91 11 6789 0123',
    },
    {
      'name': 'Breach Candy Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Breach Candy, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Prestigious hospital offering premium healthcare services with state-of-the-art medical technology.',
      'facilities': [
        'Luxury Suites',
        'Advanced Diagnostics',
        'Cosmetic Surgery',
        'Wellness Center',
      ],
      'phone': '+91 22 7890 1234',
    },
    {
      'name': 'St. John Medical College',
      'type': 'Multispeciality',
      'rating': 4.6,
      'location': 'Koramangala, Bangalore',
      'image': Icons.local_hospital,
      'about':
          'Renowned teaching hospital providing affordable tertiary care with expertise across all medical disciplines.',
      'facilities': [
        'Trauma Center',
        'Blood Bank',
        'Medical College',
        'Research Center',
      ],
      'phone': '+91 80 8901 2345',
    },
    {
      'name': 'BLK Super Specialty',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Pusa Road, Delhi',
      'image': Icons.local_hospital,
      'about':
          'Tertiary care hospital with centers of excellence in bone marrow transplant, liver transplant, and cancer care.',
      'facilities': [
        'BMT Unit',
        'Liver ICU',
        'Radiation Oncology',
        'Minimally Invasive Surgery',
      ],
      'phone': '+91 11 9012 3456',
    },
    {
      'name': 'Hinduja Hospital',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Mahim, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Leading hospital known for pioneering medical treatments and research in various specialties.',
      'facilities': [
        'Research Lab',
        'Organ Transplant',
        'Geriatric Care',
        'Preventive Health',
      ],
      'phone': '+91 22 0123 4567',
    },
    // New Hospitals - 20 additions
    {
      'name': 'Artemis Hospital',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Sector 51, Gurgaon',
      'image': Icons.local_hospital,
      'about':
          'State-of-the-art multispecialty hospital offering comprehensive healthcare with advanced medical technology and experienced specialists.',
      'facilities': [
        'Robotic Surgery',
        'Cardiac Sciences',
        'Neurosciences',
        'Cancer Care',
      ],
      'phone': '+91 124 4511 111',
    },
    {
      'name': 'Yashoda Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Secunderabad, Hyderabad',
      'image': Icons.local_hospital,
      'about':
          'Premier healthcare institution providing world-class treatment in cardiology, oncology, and organ transplantation.',
      'facilities': [
        'Heart Institute',
        'Cancer Center',
        'Kidney Transplant',
        'Emergency Care',
      ],
      'phone': '+91 40 4488 8888',
    },
    {
      'name': 'Wockhardt Hospital',
      'type': 'Multispeciality',
      'rating': 4.6,
      'location': 'Mira Road, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Advanced healthcare facility specializing in minimal access surgery, orthopedics, and critical care services.',
      'facilities': [
        'Minimal Access Surgery',
        'Joint Replacement',
        'Critical Care',
        'Diagnostics',
      ],
      'phone': '+91 22 3987 1000',
    },
    {
      'name': 'Global Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Parel, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Renowned for liver transplantation and multi-organ transplants with state-of-the-art infrastructure.',
      'facilities': [
        'Liver Transplant',
        'Multi-Organ Transplant',
        'Advanced ICU',
        'Blood Bank',
      ],
      'phone': '+91 22 6744 4444',
    },
    {
      'name': 'KIMS Hospital',
      'type': 'Multispeciality',
      'rating': 4.6,
      'location': 'Kondapur, Hyderabad',
      'image': Icons.local_hospital,
      'about':
          'Comprehensive healthcare provider with expertise in cardiac sciences, neurosciences, and oncology.',
      'facilities': [
        'Cath Lab',
        'Neuro Surgery',
        'Oncology Unit',
        'Maternity Care',
      ],
      'phone': '+91 40 4488 5555',
    },
    {
      'name': 'Continental Hospital',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Gachibowli, Hyderabad',
      'image': Icons.local_hospital,
      'about':
          'World-class hospital offering advanced treatments in cardiology, neurology, and orthopedics with international standards.',
      'facilities': [
        'Heart Center',
        'Spine Surgery',
        'Robotic Surgery',
        'Rehabilitation',
      ],
      'phone': '+91 40 6767 6767',
    },
    {
      'name': 'Sakra World Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Marathahalli, Bangalore',
      'image': Icons.local_hospital,
      'about':
          'International standard hospital with Japanese quality management providing comprehensive healthcare services.',
      'facilities': [
        'International Patients',
        'Advanced Surgery',
        'Cancer Treatment',
        'Emergency Services',
      ],
      'phone': '+91 80 4969 4969',
    },
    {
      'name': 'BGS Gleneagles',
      'type': 'Multispeciality',
      'rating': 4.6,
      'location': 'Kengeri, Bangalore',
      'image': Icons.local_hospital,
      'about':
          'Tertiary care hospital offering specialized treatments in cardiology, neurology, and orthopedics.',
      'facilities': [
        'Cardiac Care',
        'Neuro Center',
        'Joint Replacement',
        'Diagnostics',
      ],
      'phone': '+91 80 4696 9696',
    },
    {
      'name': 'Shalby Hospital',
      'type': 'Orthocare',
      'rating': 4.8,
      'location': 'SG Highway, Ahmedabad',
      'image': Icons.accessibility_new,
      'about':
          'Leading orthopedic hospital specializing in joint replacement surgeries and sports medicine.',
      'facilities': [
        'Joint Replacement',
        'Sports Medicine',
        'Arthroscopy',
        'Physiotherapy',
      ],
      'phone': '+91 79 4040 4040',
    },
    {
      'name': 'Paras Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Sector 43, Gurgaon',
      'image': Icons.local_hospital,
      'about':
          'Advanced healthcare facility with expertise in minimal access surgery, neurosciences, and cardiac care.',
      'facilities': [
        'Minimal Access Surgery',
        'Neuro Surgery',
        'Heart Center',
        'Cancer Care',
      ],
      'phone': '+91 124 458 5555',
    },
    {
      'name': 'Motherhood Hospital',
      'type': 'Maternity',
      'rating': 4.7,
      'location': 'Indiranagar, Bangalore',
      'image': Icons.pregnant_woman,
      'about':
          'Specialized maternity hospital providing comprehensive care for mothers and newborns with NICU facilities.',
      'facilities': [
        'Labor Rooms',
        'NICU Level 3',
        'Fetal Medicine',
        'Lactation Support',
      ],
      'phone': '+91 80 4897 4897',
    },
    {
      'name': 'Sparsh Hospital',
      'type': 'Orthocare',
      'rating': 4.8,
      'location': 'Yeshwanthpur, Bangalore',
      'image': Icons.accessibility_new,
      'about':
          'Super-specialty orthopedic hospital offering advanced treatments for bone and joint disorders.',
      'facilities': [
        'Joint Replacement',
        'Spine Surgery',
        'Sports Injuries',
        'Rehabilitation',
      ],
      'phone': '+91 80 4344 4344',
    },
    {
      'name': 'Gleneagles Global',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Lakdi-ka-pul, Hyderabad',
      'image': Icons.local_hospital,
      'about':
          'Multi-specialty hospital providing world-class healthcare with advanced medical technology.',
      'facilities': [
        'Cardiac Sciences',
        'Neurosciences',
        'Transplant',
        'Emergency Care',
      ],
      'phone': '+91 40 4455 4455',
    },
    {
      'name': 'Care Hospital',
      'type': 'Multispeciality',
      'rating': 4.6,
      'location': 'Banjara Hills, Hyderabad',
      'image': Icons.local_hospital,
      'about':
          'Leading healthcare provider with centers of excellence in cardiac sciences, neurosciences, and oncology.',
      'facilities': [
        'Heart Institute',
        'Neuro Center',
        'Cancer Care',
        'Kidney Transplant',
      ],
      'phone': '+91 40 6165 6165',
    },
    {
      'name': 'Mazumdar Shaw Cancer',
      'type': 'Oncology',
      'rating': 4.9,
      'location': 'Bommasandra, Bangalore',
      'image': Icons.healing,
      'about':
          'Dedicated cancer care center offering comprehensive oncology services with latest treatment modalities.',
      'facilities': [
        'Radiation Therapy',
        'Chemotherapy',
        'Immunotherapy',
        'Palliative Care',
      ],
      'phone': '+91 80 7196 0000',
    },
    {
      'name': 'Nanavati Max Hospital',
      'type': 'Multispeciality',
      'rating': 4.8,
      'location': 'Vile Parle, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Premier multi-specialty hospital offering advanced treatments across all medical disciplines.',
      'facilities': [
        'Cardiac Sciences',
        'Neurosciences',
        'Transplant',
        'Cancer Care',
      ],
      'phone': '+91 22 7157 0000',
    },
    {
      'name': 'Surya Hospital',
      'type': 'Multispeciality',
      'rating': 4.6,
      'location': 'Santacruz, Mumbai',
      'image': Icons.local_hospital,
      'about':
          'Multi-specialty hospital providing quality healthcare with focus on patient safety and care.',
      'facilities': [
        'Emergency Care',
        'Critical Care',
        'Maternity',
        'Diagnostics',
      ],
      'phone': '+91 22 6767 8888',
    },
    {
      'name': 'Venkateshwar Hospital',
      'type': 'Multispeciality',
      'rating': 4.7,
      'location': 'Dwarka, Delhi',
      'image': Icons.local_hospital,
      'about':
          'Advanced multi-specialty hospital offering comprehensive healthcare services with modern facilities.',
      'facilities': [
        'Cardiac Care',
        'Neurology',
        'Orthopedics',
        'Emergency Services',
      ],
      'phone': '+91 11 4277 4277',
    },
    {
      'name': 'Indraprastha Apollo',
      'type': 'Multispeciality',
      'rating': 4.9,
      'location': 'Sarita Vihar, Delhi',
      'image': Icons.local_hospital,
      'about':
          'Flagship hospital of Apollo Group offering world-class healthcare with cutting-edge technology.',
      'facilities': [
        'Robotic Surgery',
        'Transplant Center',
        'Cancer Institute',
        'Heart Institute',
      ],
      'phone': '+91 11 7179 1090',
    },
    // Additional Maternity Hospitals - 5 additions
    {
      'name': 'Fernandez Hospital',
      'type': 'Maternity',
      'rating': 4.8,
      'location': 'Bogulkunta, Hyderabad',
      'image': Icons.pregnant_woman,
      'about':
          'Leading maternity hospital specializing in high-risk pregnancies, fetal medicine, and neonatal care with advanced NICU facilities.',
      'facilities': [
        'High-Risk Pregnancy',
        'Fetal Medicine',
        'NICU Level 3',
        'IVF Center',
      ],
      'phone': '+91 40 4780 0000',
    },
    {
      'name': 'Nova IVF Fertility',
      'type': 'Maternity',
      'rating': 4.7,
      'location': 'Koramangala, Bangalore',
      'image': Icons.pregnant_woman,
      'about':
          'Specialized fertility and maternity center offering comprehensive reproductive healthcare and prenatal services.',
      'facilities': [
        'IVF Treatment',
        'Prenatal Care',
        'Genetic Counseling',
        'Maternity Ward',
      ],
      'phone': '+91 80 4673 4673',
    },
    {
      'name': 'Birthright Hospital',
      'type': 'Maternity',
      'rating': 4.6,
      'location': 'Malad, Mumbai',
      'image': Icons.pregnant_woman,
      'about':
          'Dedicated maternity hospital providing personalized care for mothers and babies with modern labor and delivery suites.',
      'facilities': [
        'Labor Suites',
        'Cesarean Section',
        'Newborn Care',
        'Breastfeeding Support',
      ],
      'phone': '+91 22 2888 6666',
    },
    {
      'name': 'Sitaram Bhartia',
      'type': 'Maternity',
      'rating': 4.8,
      'location': 'South Delhi, Delhi',
      'image': Icons.pregnant_woman,
      'about':
          'Renowned maternity hospital known for natural birthing practices and comprehensive women\'s healthcare services.',
      'facilities': [
        'Natural Birth Center',
        'Water Birth',
        'NICU',
        'Lactation Clinic',
      ],
      'phone': '+91 11 4211 1111',
    },
    {
      'name': 'Surya Mother & Child',
      'type': 'Maternity',
      'rating': 4.7,
      'location': 'Wakad, Pune',
      'image': Icons.pregnant_woman,
      'about':
          'Specialized mother and child care hospital offering comprehensive maternity services and pediatric care under one roof.',
      'facilities': [
        'Maternity Care',
        'Pediatric ICU',
        'Vaccination Center',
        'Child Development',
      ],
      'phone': '+91 20 6712 7777',
    },
    // Neurology Hospitals - 5 additions
    {
      'name': 'National Brain Centre',
      'type': 'Neurology',
      'rating': 4.9,
      'location': 'Parel, Mumbai',
      'image': Icons.psychology,
      'about':
          'Premier neurology center specializing in brain and spine disorders with advanced neuroimaging and neurosurgery facilities.',
      'facilities': [
        'Advanced MRI',
        'Neurosurgery',
        'Stroke Unit',
        'Epilepsy Center',
      ],
      'phone': '+91 22 2416 7676',
    },
    {
      'name': 'Jaslok Neuro Centre',
      'type': 'Neurology',
      'rating': 4.8,
      'location': 'Pedder Road, Mumbai',
      'image': Icons.psychology,
      'about':
          'Specialized neurology department offering comprehensive treatment for neurological disorders including Parkinson\'s and Alzheimer\'s.',
      'facilities': [
        'Neuro ICU',
        'EEG Lab',
        'Movement Disorders',
        'Neuro Rehabilitation',
      ],
      'phone': '+91 22 6657 3333',
    },
    {
      'name': 'Bangalore Neuro Institute',
      'type': 'Neurology',
      'rating': 4.9,
      'location': 'Banashankari, Bangalore',
      'image': Icons.psychology,
      'about':
          'Dedicated neurosciences institute providing world-class treatment for brain, spine, and nerve disorders.',
      'facilities': [
        'Brain Surgery',
        'Spine Surgery',
        'Stroke Care',
        'Neuro Diagnostics',
      ],
      'phone': '+91 80 2699 2699',
    },
    {
      'name': 'Yashoda Neuro Sciences',
      'type': 'Neurology',
      'rating': 4.7,
      'location': 'Malakpet, Hyderabad',
      'image': Icons.psychology,
      'about':
          'Advanced neurosciences center with expertise in minimally invasive neurosurgery and comprehensive neurological care.',
      'facilities': [
        'Minimally Invasive Surgery',
        'Neuro Oncology',
        'Pediatric Neurology',
        'Pain Management',
      ],
      'phone': '+91 40 6815 5555',
    },
    {
      'name': 'Delhi Brain & Spine',
      'type': 'Neurology',
      'rating': 4.8,
      'location': 'Rohini, Delhi',
      'image': Icons.psychology,
      'about':
          'Specialized brain and spine hospital offering advanced treatments for neurological and spinal disorders.',
      'facilities': [
        'Spine Surgery',
        'Brain Tumor Surgery',
        'Neuro Rehabilitation',
        'Headache Clinic',
      ],
      'phone': '+91 11 4777 4777',
    },
  ];

  List<Map<String, dynamic>> _filteredHospitals = [];

  final List<String> _categories = [
    'All',
    'Multispeciality',
    'Eye Specialist',
    'Pediatric Clinic',
    'Dental Care',
    'Orthocare',
    'Neurology',
    'Cardiology',
    'Dermatology',
    'Mental Health',
    'Oncology',
    'Maternity',
    'Emergency Care',
  ];

  @override
  void initState() {
    super.initState();
    _filteredHospitals = _allHospitals;
    _searchController.addListener(_filterHospitals);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterHospitals() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredHospitals = _allHospitals.where((hospital) {
        final matchesQuery =
            hospital['name'].toLowerCase().contains(query) ||
            hospital['location'].toLowerCase().contains(query);
        final matchesCategory =
            _selectedCategory == 'All' || hospital['type'] == _selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Hospitals'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HospitalMapScreen(hospitals: _filteredHospitals),
                ),
              );
            },
            icon: const Icon(Icons.map_outlined),
            tooltip: 'Map View',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilters(),
          Expanded(
            child: _filteredHospitals.isEmpty
                ? const Center(child: Text('No hospitals found.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredHospitals.length,
                    itemBuilder: (context, index) {
                      final hospital = _filteredHospitals[index];
                      return _hospitalCard(context, hospital);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search hospital or area...',
          prefixIcon: const Icon(Icons.search, color: Colors.indigo),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (category == 'All') {
                  // For "All" category, just filter in place
                  setState(() {
                    _selectedCategory = category;
                    _filterHospitals();
                  });
                } else {
                  // For specific categories, navigate to detail screen
                  final categoryHospitals = _allHospitals
                      .where((h) => h['type'] == category)
                      .toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalCategoryDetailScreen(
                        categoryName: category,
                        hospitals: categoryHospitals,
                        icon: _getCategoryIcon(category),
                        color: _getCategoryColor(category),
                      ),
                    ),
                  );
                }
              },
              selectedColor: Colors.indigo,
              backgroundColor: Colors.indigo.withOpacity(0.1),
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Multispeciality':
        return Icons.local_hospital;
      case 'Eye Specialist':
        return Icons.visibility;
      case 'Pediatric Clinic':
        return Icons.child_care;
      case 'Dental Care':
        return Icons.medical_services;
      case 'Orthocare':
        return Icons.accessibility_new;
      case 'Neurology':
        return Icons.psychology;
      case 'Cardiology':
        return Icons.favorite;
      case 'Dermatology':
        return Icons.face;
      case 'Mental Health':
        return Icons.spa;
      case 'Oncology':
        return Icons.healing;
      case 'Maternity':
        return Icons.pregnant_woman;
      case 'Emergency Care':
        return Icons.emergency;
      default:
        return Icons.local_hospital;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Multispeciality':
        return Colors.indigo;
      case 'Eye Specialist':
        return Colors.blue;
      case 'Pediatric Clinic':
        return Colors.pink;
      case 'Dental Care':
        return Colors.teal;
      case 'Orthocare':
        return Colors.orange;
      case 'Neurology':
        return Colors.purple;
      case 'Cardiology':
        return Colors.red;
      case 'Dermatology':
        return Colors.amber;
      case 'Mental Health':
        return Colors.green;
      case 'Oncology':
        return Colors.deepPurple;
      case 'Maternity':
        return Colors.pinkAccent;
      case 'Emergency Care':
        return Colors.redAccent;
      default:
        return Colors.indigo;
    }
  }

  Widget _hospitalCard(BuildContext context, Map<String, dynamic> hospital) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalProfileScreen(hospital: hospital),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  hospital['image'] as IconData,
                  size: 40,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospital['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hospital['type'],
                      style: TextStyle(
                        color: Colors.indigo.shade700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          hospital['location'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          hospital['rating'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
