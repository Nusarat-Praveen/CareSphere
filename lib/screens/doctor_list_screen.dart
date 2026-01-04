import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';
import 'doctor_map_screen.dart';
import 'doctor_category_detail_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = 'All';

  final List<Map<String, dynamic>> _allDoctors = [
    {
      'name': 'Dr. Anjali Sharma',
      'speciality': 'Cardiologist',
      'experience': '12 years',
      'rating': 4.8,
      'patients': '1.5k+',
      'location': 'City Heart Hospital, Mumbai',
      'about':
          'Dr. Anjali Sharma is a renowned Cardiologist with over a decade of experience in treating complex heart conditions. She is dedicated to providing personalized care to her patients.',
      'availability': 'Mon - Sat, 10:00 AM - 04:00 PM',
      'fee': '₹800',
    },
    {
      'name': 'Dr. Rahul Verma',
      'speciality': 'Dermatologist',
      'experience': '8 years',
      'rating': 4.5,
      'patients': '900+',
      'location': 'Skin Care Clinic, Delhi',
      'about':
          'Dr. Rahul Verma specializes in clinical and cosmetic dermatology. He is known for his effective treatments for acne, eczema, and hair loss.',
      'availability': 'Mon - Fri, 09:00 AM - 02:00 PM',
      'fee': '₹600',
    },
    {
      'name': 'Dr. Sneha Patel',
      'speciality': 'Pediatrician',
      'experience': '10 years',
      'rating': 4.7,
      'patients': '2k+',
      'location': 'Happy Kids Hospital, Ahmedabad',
      'about':
          'Dr. Sneha Patel is a compassionate Pediatrician who loves working with children. She focuses on preventive healthcare and vaccination.',
      'availability': 'Mon - Sat, 11:00 AM - 06:00 PM',
      'fee': '₹700',
    },
    {
      'name': 'Dr. Ishita Iyer',
      'speciality': 'Dermatologist',
      'experience': '6 years',
      'rating': 4.6,
      'patients': '1.2k+',
      'location': 'Glow Skin Center, Bangalore',
      'about':
          'Dr. Ishita Iyer is an expert in modern dermatological procedures. She offers treatments for skin rejuvenation and anti-aging.',
      'availability': 'Tue - Sun, 10:00 AM - 05:00 PM',
      'fee': '₹650',
    },
    {
      'name': 'Dr. Manoj Bhargava',
      'speciality': 'Orthopedic Surgeon',
      'experience': '15 years',
      'rating': 4.9,
      'patients': '3k+',
      'location': 'Bone & Joint Institute, Chennai',
      'about':
          'Dr. Manoj Bhargava is a senior Orthopedic Surgeon specializing in joint replacement and sports injuries. He has performed over 500 successful surgeries.',
      'availability': 'Mon - Fri, 08:00 AM - 03:00 PM',
      'fee': '₹1000',
    },
    {
      'name': 'Dr. Shalini Gupta',
      'speciality': 'Neurologist',
      'experience': '9 years',
      'rating': 4.8,
      'patients': '800+',
      'location': 'Neuro Care Center, Hyderabad',
      'about':
          'Dr. Shalini Gupta deals with disorders of the nervous system. She has a special interest in treating migraine and epilepsy.',
      'availability': 'Mon - Sat, 09:00 AM - 01:00 PM',
      'fee': '₹900',
    },
    {
      'name': 'Dr. Deepak Lamba',
      'speciality': 'Dentist',
      'experience': '7 years',
      'rating': 4.5,
      'patients': '1.1k+',
      'location': 'Smile Dental Clinic, Pune',
      'about':
          'Dr. Deepak Lamba provides comprehensive dental care, including root canals, implants, and cosmetic dentistry. He ensures a pain-free experience.',
      'availability': 'Mon - Sat, 10:00 AM - 08:00 PM',
      'fee': '₹500',
    },
    // New Doctors
    {
      'name': 'Dr. Vikram Reddy',
      'speciality': 'Cardiologist',
      'experience': '18 years',
      'rating': 4.9,
      'patients': '4k+',
      'location': 'Apollo Hospital, Hyderabad',
      'about':
          'Dr. Vikram Reddy is a leading interventional cardiologist specializing in angioplasty and heart valve procedures. He has pioneered minimally invasive cardiac techniques.',
      'availability': 'Mon - Sat, 09:00 AM - 02:00 PM',
      'fee': '₹1200',
    },
    {
      'name': 'Dr. Priya Menon',
      'speciality': 'Gynecologist',
      'experience': '11 years',
      'rating': 4.7,
      'patients': '2.5k+',
      'location': 'Cloudnine Hospital, Bangalore',
      'about':
          'Dr. Priya Menon specializes in high-risk pregnancies and minimally invasive gynecological surgeries. She is known for her compassionate approach to women\'s health.',
      'availability': 'Mon - Fri, 10:00 AM - 05:00 PM',
      'fee': '₹850',
    },
    {
      'name': 'Dr. Arjun Nair',
      'speciality': 'Oncologist',
      'experience': '14 years',
      'rating': 4.8,
      'patients': '1.8k+',
      'location': 'Tata Memorial Hospital, Mumbai',
      'about':
          'Dr. Arjun Nair is a medical oncologist with expertise in chemotherapy and immunotherapy. He has contributed to several cancer research publications.',
      'availability': 'Tue - Sat, 11:00 AM - 04:00 PM',
      'fee': '₹1100',
    },
    {
      'name': 'Dr. Kavita Deshmukh',
      'speciality': 'Ophthalmologist',
      'experience': '10 years',
      'rating': 4.6,
      'patients': '2.2k+',
      'location': 'Sankara Eye Hospital, Chennai',
      'about':
          'Dr. Kavita Deshmukh specializes in cataract surgery and retinal disorders. She has performed over 3000 successful eye surgeries with advanced laser technology.',
      'availability': 'Mon - Sat, 08:00 AM - 02:00 PM',
      'fee': '₹700',
    },
    {
      'name': 'Dr. Suresh Kumar',
      'speciality': 'Gastroenterologist',
      'experience': '13 years',
      'rating': 4.7,
      'patients': '1.6k+',
      'location': 'Fortis Hospital, Delhi',
      'about':
          'Dr. Suresh Kumar is an expert in digestive disorders and endoscopic procedures. He specializes in treating liver diseases and inflammatory bowel conditions.',
      'availability': 'Mon - Fri, 09:00 AM - 03:00 PM',
      'fee': '₹950',
    },
    {
      'name': 'Dr. Meera Krishnan',
      'speciality': 'Psychiatrist',
      'experience': '9 years',
      'rating': 4.5,
      'patients': '1.3k+',
      'location': 'NIMHANS, Bangalore',
      'about':
          'Dr. Meera Krishnan provides comprehensive mental health care including therapy for depression, anxiety, and bipolar disorder. She believes in holistic treatment approaches.',
      'availability': 'Mon - Sat, 02:00 PM - 07:00 PM',
      'fee': '₹800',
    },
    {
      'name': 'Dr. Rajesh Kapoor',
      'speciality': 'Urologist',
      'experience': '16 years',
      'rating': 4.8,
      'patients': '2.8k+',
      'location': 'Max Hospital, Delhi',
      'about':
          'Dr. Rajesh Kapoor specializes in kidney stone treatment, prostate disorders, and minimally invasive urological surgeries. He is known for his expertise in robotic surgery.',
      'availability': 'Tue - Sat, 10:00 AM - 04:00 PM',
      'fee': '₹1000',
    },
    {
      'name': 'Dr. Divya Rao',
      'speciality': 'Endocrinologist',
      'experience': '8 years',
      'rating': 4.6,
      'patients': '1.4k+',
      'location': 'Manipal Hospital, Bangalore',
      'about':
          'Dr. Divya Rao specializes in diabetes management, thyroid disorders, and hormonal imbalances. She focuses on lifestyle modifications and personalized treatment plans.',
      'availability': 'Mon - Fri, 11:00 AM - 05:00 PM',
      'fee': '₹750',
    },
    {
      'name': 'Dr. Aditya Joshi',
      'speciality': 'Pulmonologist',
      'experience': '12 years',
      'rating': 4.7,
      'patients': '1.9k+',
      'location': 'Kokilaben Hospital, Mumbai',
      'about':
          'Dr. Aditya Joshi is an expert in respiratory diseases including asthma, COPD, and sleep disorders. He uses advanced diagnostic techniques for lung conditions.',
      'availability': 'Mon - Sat, 09:00 AM - 02:00 PM',
      'fee': '₹900',
    },
    {
      'name': 'Dr. Pooja Malhotra',
      'speciality': 'Rheumatologist',
      'experience': '10 years',
      'rating': 4.5,
      'patients': '1.1k+',
      'location': 'AIIMS, Delhi',
      'about':
          'Dr. Pooja Malhotra treats autoimmune diseases, arthritis, and musculoskeletal disorders. She is experienced in biologic therapies and pain management.',
      'availability': 'Tue - Fri, 10:00 AM - 03:00 PM',
      'fee': '₹850',
    },
    {
      'name': 'Dr. Karthik Subramanian',
      'speciality': 'Nephrologist',
      'experience': '15 years',
      'rating': 4.9,
      'patients': '2.6k+',
      'location': 'Apollo Hospital, Chennai',
      'about':
          'Dr. Karthik Subramanian specializes in kidney diseases, dialysis, and kidney transplantation. He has successfully managed over 200 transplant cases.',
      'availability': 'Mon - Sat, 08:00 AM - 01:00 PM',
      'fee': '₹1100',
    },
    {
      'name': 'Dr. Nandini Chatterjee',
      'speciality': 'Pediatrician',
      'experience': '11 years',
      'rating': 4.8,
      'patients': '3.2k+',
      'location': 'Rainbow Hospital, Kolkata',
      'about':
          'Dr. Nandini Chatterjee is a pediatric specialist focusing on newborn care, childhood infections, and developmental disorders. She is loved by children and parents alike.',
      'availability': 'Mon - Sat, 10:00 AM - 06:00 PM',
      'fee': '₹650',
    },
    {
      'name': 'Dr. Sameer Bhatia',
      'speciality': 'Neurosurgeon',
      'experience': '17 years',
      'rating': 4.9,
      'patients': '2.1k+',
      'location': 'Medanta Hospital, Gurgaon',
      'about':
          'Dr. Sameer Bhatia is a highly skilled neurosurgeon specializing in brain and spine surgeries. He has expertise in minimally invasive techniques and tumor removal.',
      'availability': 'Mon - Fri, 09:00 AM - 02:00 PM',
      'fee': '₹1500',
    },
    {
      'name': 'Dr. Lakshmi Iyer',
      'speciality': 'Dermatologist',
      'experience': '9 years',
      'rating': 4.6,
      'patients': '1.7k+',
      'location': 'Skin & You Clinic, Bangalore',
      'about':
          'Dr. Lakshmi Iyer offers advanced treatments for skin conditions, laser therapy, and cosmetic procedures. She specializes in acne scar treatment and anti-aging solutions.',
      'availability': 'Tue - Sun, 11:00 AM - 06:00 PM',
      'fee': '₹700',
    },
    {
      'name': 'Dr. Harish Pillai',
      'speciality': 'Orthopedic Surgeon',
      'experience': '14 years',
      'rating': 4.8,
      'patients': '2.4k+',
      'location': 'Fortis Hospital, Bangalore',
      'about':
          'Dr. Harish Pillai specializes in sports medicine, arthroscopic surgery, and joint replacement. He has treated numerous professional athletes and sports injuries.',
      'availability': 'Mon - Sat, 08:00 AM - 02:00 PM',
      'fee': '₹1050',
    },
    {
      'name': 'Dr. Ritu Agarwal',
      'speciality': 'Radiologist',
      'experience': '10 years',
      'rating': 4.7,
      'patients': '2k+',
      'location': 'Jaslok Hospital, Mumbai',
      'about':
          'Dr. Ritu Agarwal is an expert in diagnostic imaging including MRI, CT scans, and interventional radiology. She provides accurate diagnoses for complex medical conditions.',
      'availability': 'Mon - Fri, 09:00 AM - 05:00 PM',
      'fee': '₹800',
    },
    {
      'name': 'Dr. Ashwin Mehta',
      'speciality': 'ENT Specialist',
      'experience': '13 years',
      'rating': 4.6,
      'patients': '1.8k+',
      'location': 'Lilavati Hospital, Mumbai',
      'about':
          'Dr. Ashwin Mehta treats ear, nose, and throat disorders including sinusitis, hearing loss, and voice disorders. He performs advanced endoscopic sinus surgeries.',
      'availability': 'Tue - Sat, 10:00 AM - 04:00 PM',
      'fee': '₹850',
    },
    {
      'name': 'Dr. Tanvi Desai',
      'speciality': 'Dentist',
      'experience': '8 years',
      'rating': 4.5,
      'patients': '1.5k+',
      'location': 'Dental Care Plus, Ahmedabad',
      'about':
          'Dr. Tanvi Desai provides comprehensive dental services including orthodontics, dental implants, and smile makeovers. She uses the latest technology for painless treatments.',
      'availability': 'Mon - Sat, 09:00 AM - 07:00 PM',
      'fee': '₹550',
    },
    {
      'name': 'Dr. Naveen Reddy',
      'speciality': 'General Surgeon',
      'experience': '16 years',
      'rating': 4.8,
      'patients': '3.5k+',
      'location': 'Care Hospital, Hyderabad',
      'about':
          'Dr. Naveen Reddy is an experienced general surgeon specializing in laparoscopic and bariatric surgery. He has performed thousands of minimally invasive procedures.',
      'availability': 'Mon - Fri, 08:00 AM - 03:00 PM',
      'fee': '₹1000',
    },
    // New Doctors - 20 additions
    {
      'name': 'Dr. Aarav Malhotra',
      'speciality': 'Cardiologist',
      'experience': '14 years',
      'rating': 4.8,
      'patients': '2.8k+',
      'location': 'Fortis Hospital, Noida',
      'about':
          'Dr. Aarav Malhotra specializes in interventional cardiology and heart failure management. He has expertise in complex angioplasty procedures and cardiac rehabilitation.',
      'availability': 'Mon - Sat, 10:00 AM - 03:00 PM',
      'fee': '₹1100',
    },
    {
      'name': 'Dr. Ishani Chatterjee',
      'speciality': 'Dermatologist',
      'experience': '9 years',
      'rating': 4.6,
      'patients': '1.9k+',
      'location': 'Skin Clinic, Kolkata',
      'about':
          'Dr. Ishani Chatterjee offers advanced dermatological treatments including laser therapy, chemical peels, and treatment for chronic skin conditions.',
      'availability': 'Tue - Sun, 11:00 AM - 06:00 PM',
      'fee': '₹750',
    },
    {
      'name': 'Dr. Rohan Kulkarni',
      'speciality': 'Orthopedic Surgeon',
      'experience': '17 years',
      'rating': 4.9,
      'patients': '3.2k+',
      'location': 'Ruby Hall Clinic, Pune',
      'about':
          'Dr. Rohan Kulkarni is a renowned orthopedic surgeon specializing in knee and hip replacement surgeries. He has performed over 800 successful joint replacements.',
      'availability': 'Mon - Fri, 08:00 AM - 02:00 PM',
      'fee': '₹1200',
    },
    {
      'name': 'Dr. Ananya Iyer',
      'speciality': 'Pediatrician',
      'experience': '12 years',
      'rating': 4.7,
      'patients': '3.8k+',
      'location': 'Apollo Cradle, Chennai',
      'about':
          'Dr. Ananya Iyer is a dedicated pediatrician with expertise in neonatal care and childhood immunization. She is known for her gentle approach with children.',
      'availability': 'Mon - Sat, 09:00 AM - 05:00 PM',
      'fee': '₹700',
    },
    {
      'name': 'Dr. Kabir Singh',
      'speciality': 'Neurologist',
      'experience': '11 years',
      'rating': 4.7,
      'patients': '1.5k+',
      'location': 'Max Hospital, Gurgaon',
      'about':
          'Dr. Kabir Singh specializes in treating stroke, epilepsy, and movement disorders. He uses advanced neuroimaging techniques for accurate diagnosis.',
      'availability': 'Mon - Sat, 10:00 AM - 02:00 PM',
      'fee': '₹950',
    },
    {
      'name': 'Dr. Shreya Kapoor',
      'speciality': 'Gynecologist',
      'experience': '13 years',
      'rating': 4.8,
      'patients': '2.9k+',
      'location': 'Fortis La Femme, Delhi',
      'about':
          'Dr. Shreya Kapoor is an expert in high-risk obstetrics and laparoscopic gynecological surgeries. She provides comprehensive women\'s healthcare services.',
      'availability': 'Mon - Fri, 11:00 AM - 06:00 PM',
      'fee': '₹900',
    },
    {
      'name': 'Dr. Arjun Sharma',
      'speciality': 'Dentist',
      'experience': '10 years',
      'rating': 4.6,
      'patients': '2.1k+',
      'location': 'Clove Dental, Bangalore',
      'about':
          'Dr. Arjun Sharma provides advanced dental care including implants, orthodontics, and cosmetic dentistry. He specializes in smile design and full mouth rehabilitation.',
      'availability': 'Mon - Sat, 09:00 AM - 08:00 PM',
      'fee': '₹600',
    },
    {
      'name': 'Dr. Nisha Patel',
      'speciality': 'Ophthalmologist',
      'experience': '15 years',
      'rating': 4.9,
      'patients': '3.5k+',
      'location': 'Centre for Sight, Ahmedabad',
      'about':
          'Dr. Nisha Patel is a leading ophthalmologist specializing in cataract surgery, LASIK, and retinal diseases. She has performed over 5000 successful eye surgeries.',
      'availability': 'Mon - Sat, 08:00 AM - 03:00 PM',
      'fee': '₹850',
    },
    {
      'name': 'Dr. Vivek Agarwal',
      'speciality': 'ENT Specialist',
      'experience': '12 years',
      'rating': 4.7,
      'patients': '2.3k+',
      'location': 'Medanta Hospital, Gurgaon',
      'about':
          'Dr. Vivek Agarwal treats ear, nose, and throat disorders with expertise in endoscopic sinus surgery and cochlear implants. He specializes in voice and swallowing disorders.',
      'availability': 'Tue - Sat, 10:00 AM - 05:00 PM',
      'fee': '₹900',
    },
    {
      'name': 'Dr. Pooja Verma',
      'speciality': 'Psychiatrist',
      'experience': '10 years',
      'rating': 4.6,
      'patients': '1.7k+',
      'location': 'Fortis Hospital, Mumbai',
      'about':
          'Dr. Pooja Verma provides comprehensive mental health care including therapy for anxiety, depression, and stress management. She uses evidence-based treatment approaches.',
      'availability': 'Mon - Sat, 03:00 PM - 08:00 PM',
      'fee': '₹850',
    },
    {
      'name': 'Dr. Aditya Deshmukh',
      'speciality': 'Oncologist',
      'experience': '16 years',
      'rating': 4.9,
      'patients': '2.2k+',
      'location': 'HCG Cancer Centre, Bangalore',
      'about':
          'Dr. Aditya Deshmukh is a medical oncologist with expertise in targeted therapy and immunotherapy for various cancers. He has contributed to multiple clinical trials.',
      'availability': 'Mon - Fri, 11:00 AM - 04:00 PM',
      'fee': '₹1200',
    },
    {
      'name': 'Dr. Riya Banerjee',
      'speciality': 'Endocrinologist',
      'experience': '9 years',
      'rating': 4.5,
      'patients': '1.6k+',
      'location': 'Apollo Hospital, Kolkata',
      'about':
          'Dr. Riya Banerjee specializes in diabetes, thyroid disorders, and hormonal imbalances. She focuses on personalized treatment plans and lifestyle modifications.',
      'availability': 'Mon - Fri, 10:00 AM - 04:00 PM',
      'fee': '₹800',
    },
    {
      'name': 'Dr. Siddharth Rao',
      'speciality': 'Gastroenterologist',
      'experience': '14 years',
      'rating': 4.8,
      'patients': '2.4k+',
      'location': 'Asian Institute, Mumbai',
      'about':
          'Dr. Siddharth Rao is an expert in digestive disorders, liver diseases, and therapeutic endoscopy. He specializes in inflammatory bowel disease management.',
      'availability': 'Mon - Sat, 09:00 AM - 02:00 PM',
      'fee': '₹1000',
    },
    {
      'name': 'Dr. Kavya Menon',
      'speciality': 'Pulmonologist',
      'experience': '11 years',
      'rating': 4.7,
      'patients': '1.8k+',
      'location': 'Manipal Hospital, Bangalore',
      'about':
          'Dr. Kavya Menon treats respiratory diseases including asthma, COPD, and sleep apnea. She uses advanced pulmonary function testing and bronchoscopy.',
      'availability': 'Mon - Sat, 10:00 AM - 03:00 PM',
      'fee': '₹900',
    },
    {
      'name': 'Dr. Rahul Joshi',
      'speciality': 'Urologist',
      'experience': '15 years',
      'rating': 4.8,
      'patients': '2.7k+',
      'location': 'Lilavati Hospital, Mumbai',
      'about':
          'Dr. Rahul Joshi specializes in kidney stone treatment, prostate disorders, and urological cancers. He is skilled in minimally invasive and robotic urological surgeries.',
      'availability': 'Tue - Sat, 09:00 AM - 03:00 PM',
      'fee': '₹1050',
    },
    {
      'name': 'Dr. Priya Saxena',
      'speciality': 'Rheumatologist',
      'experience': '10 years',
      'rating': 4.6,
      'patients': '1.4k+',
      'location': 'Max Hospital, Delhi',
      'about':
          'Dr. Priya Saxena treats autoimmune diseases, arthritis, and connective tissue disorders. She specializes in biologic therapies and joint injections.',
      'availability': 'Mon - Fri, 11:00 AM - 04:00 PM',
      'fee': '₹900',
    },
    {
      'name': 'Dr. Karan Mehta',
      'speciality': 'Nephrologist',
      'experience': '13 years',
      'rating': 4.8,
      'patients': '2.1k+',
      'location': 'Fortis Hospital, Chennai',
      'about':
          'Dr. Karan Mehta specializes in kidney diseases, dialysis management, and kidney transplantation. He has successfully managed over 150 transplant patients.',
      'availability': 'Mon - Sat, 08:00 AM - 02:00 PM',
      'fee': '₹1100',
    },
    {
      'name': 'Dr. Neha Gupta',
      'speciality': 'Neurosurgeon',
      'experience': '18 years',
      'rating': 4.9,
      'patients': '2.5k+',
      'location': 'AIIMS, Delhi',
      'about':
          'Dr. Neha Gupta is a highly skilled neurosurgeon specializing in brain tumors, spine surgery, and cerebrovascular disorders. She has expertise in minimally invasive neurosurgery.',
      'availability': 'Mon - Fri, 09:00 AM - 01:00 PM',
      'fee': '₹1600',
    },
    {
      'name': 'Dr. Amit Kumar',
      'speciality': 'Radiologist',
      'experience': '12 years',
      'rating': 4.7,
      'patients': '2.6k+',
      'location': 'Medanta Hospital, Gurgaon',
      'about':
          'Dr. Amit Kumar is an expert in diagnostic and interventional radiology. He specializes in MRI, CT imaging, and image-guided procedures for accurate diagnosis.',
      'availability': 'Mon - Fri, 08:00 AM - 04:00 PM',
      'fee': '₹850',
    },
    {
      'name': 'Dr. Simran Kaur',
      'speciality': 'General Surgeon',
      'experience': '14 years',
      'rating': 4.7,
      'patients': '2.9k+',
      'location': 'Apollo Hospital, Ludhiana',
      'about':
          'Dr. Simran Kaur is an experienced general surgeon specializing in laparoscopic surgery, hernia repair, and gastrointestinal surgeries. She focuses on minimally invasive techniques.',
      'availability': 'Mon - Sat, 09:00 AM - 03:00 PM',
      'fee': '₹950',
    },
  ];

  List<Map<String, dynamic>> _filteredDoctors = [];

  final List<String> _specialties = [
    'All',
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Orthopedic Surgeon',
    'Neurologist',
    'Dentist',
    'Gynecologist',
    'Oncologist',
    'Ophthalmologist',
    'Gastroenterologist',
    'Psychiatrist',
    'Urologist',
    'Endocrinologist',
    'Pulmonologist',
    'Rheumatologist',
    'Nephrologist',
    'Neurosurgeon',
    'Radiologist',
    'ENT Specialist',
    'General Surgeon',
  ];

  @override
  void initState() {
    super.initState();
    _filteredDoctors = _allDoctors;
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
      _filteredDoctors = _allDoctors.where((doctor) {
        final matchesQuery =
            doctor['name'].toLowerCase().contains(query) ||
            doctor['speciality'].toLowerCase().contains(query);
        final matchesSpecialty =
            _selectedSpecialty == 'All' ||
            doctor['speciality'] == _selectedSpecialty;
        return matchesQuery && matchesSpecialty;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DoctorMapScreen(doctors: _filteredDoctors),
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
          _buildSpecialtyFilters(),
          Expanded(
            child: _filteredDoctors.isEmpty
                ? const Center(child: Text('No doctors found.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = _filteredDoctors[index];
                      return _doctorCard(context, doctor);
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
          hintText: 'Search doctor or specialty...',
          prefixIcon: const Icon(Icons.search, color: Colors.teal),
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

  Widget _buildSpecialtyFilters() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _specialties.length,
        itemBuilder: (context, index) {
          final specialty = _specialties[index];
          final isSelected = _selectedSpecialty == specialty;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(
                specialty,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (specialty == 'All') {
                  // For "All" specialty, just filter in place
                  setState(() {
                    _selectedSpecialty = specialty;
                    _filterDoctors();
                  });
                } else {
                  // For specific specialties, navigate to detail screen
                  final specialtyDoctors = _allDoctors
                      .where((d) => d['speciality'] == specialty)
                      .toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorCategoryDetailScreen(
                        specialtyName: specialty,
                        doctors: specialtyDoctors,
                        icon: _getSpecialtyIcon(specialty),
                        color: _getSpecialtyColor(specialty),
                      ),
                    ),
                  );
                }
              },
              selectedColor: Colors.teal,
              backgroundColor: Colors.teal.withOpacity(0.1),
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

  IconData _getSpecialtyIcon(String specialty) {
    switch (specialty) {
      case 'Cardiologist':
        return Icons.favorite;
      case 'Dermatologist':
        return Icons.face;
      case 'Pediatrician':
        return Icons.child_care;
      case 'Orthopedic Surgeon':
        return Icons.accessibility_new;
      case 'Neurologist':
        return Icons.psychology;
      case 'Dentist':
        return Icons.medical_services;
      case 'Gynecologist':
        return Icons.pregnant_woman;
      case 'Oncologist':
        return Icons.healing;
      case 'Ophthalmologist':
        return Icons.visibility;
      case 'Gastroenterologist':
        return Icons.restaurant;
      case 'Psychiatrist':
        return Icons.spa;
      case 'Urologist':
        return Icons.water_drop;
      case 'Endocrinologist':
        return Icons.science;
      case 'Pulmonologist':
        return Icons.air;
      case 'Rheumatologist':
        return Icons.healing_outlined;
      case 'Nephrologist':
        return Icons.water;
      case 'Neurosurgeon':
        return Icons.psychology_outlined;
      case 'Radiologist':
        return Icons.camera_alt;
      case 'ENT Specialist':
        return Icons.hearing;
      case 'General Surgeon':
        return Icons.local_hospital;
      default:
        return Icons.person;
    }
  }

  Color _getSpecialtyColor(String specialty) {
    switch (specialty) {
      case 'Cardiologist':
        return Colors.red;
      case 'Dermatologist':
        return Colors.amber;
      case 'Pediatrician':
        return Colors.pink;
      case 'Orthopedic Surgeon':
        return Colors.orange;
      case 'Neurologist':
        return Colors.purple;
      case 'Dentist':
        return Colors.teal;
      case 'Gynecologist':
        return Colors.pinkAccent;
      case 'Oncologist':
        return Colors.deepPurple;
      case 'Ophthalmologist':
        return Colors.blue;
      case 'Gastroenterologist':
        return Colors.brown;
      case 'Psychiatrist':
        return Colors.green;
      case 'Urologist':
        return Colors.lightBlue;
      case 'Endocrinologist':
        return Colors.indigo;
      case 'Pulmonologist':
        return Colors.cyan;
      case 'Rheumatologist':
        return Colors.lime;
      case 'Nephrologist':
        return Colors.blueGrey;
      case 'Neurosurgeon':
        return Colors.deepOrange;
      case 'Radiologist':
        return Colors.grey;
      case 'ENT Specialist':
        return Colors.tealAccent;
      case 'General Surgeon':
        return Colors.redAccent;
      default:
        return Colors.teal;
    }
  }

  Widget _doctorCard(BuildContext context, Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              backgroundColor: Colors.teal.shade100,
              child: const Icon(Icons.person, size: 32, color: Colors.teal),
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
                    style: TextStyle(color: Colors.teal.shade700),
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
                backgroundColor: Colors.teal,
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
