import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'category_detail_screen.dart';
import 'medicine_search_screen.dart';
import 'medicine_detail_screen.dart';

class MedicineShopScreen extends StatefulWidget {
  const MedicineShopScreen({super.key});

  @override
  State<MedicineShopScreen> createState() => _MedicineShopScreenState();
}

class _MedicineShopScreenState extends State<MedicineShopScreen> {
  // Mock Cart State
  int _cartItemCount = 0;
  double _cartTotal = 0.0;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredMedicines = [];
  final String _selectedCategory = "All";

  final List<Map<String, dynamic>> _medicines = [
    // Essentials
    {
      "name": "Paracetamol 650",
      "dosage": "15 Tablets",
      "price": 30.0,
      "originalPrice": 45.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Dolo 650",
      "dosage": "15 Tablets",
      "price": 32.0,
      "originalPrice": 40.0,
      "image": Icons.local_pharmacy,
      "color": Colors.red,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Digene Gel",
      "dosage": "200ml Syrup",
      "price": 180.0,
      "originalPrice": 210.0,
      "image": Icons.liquor,
      "color": Colors.pink,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Crocin 500",
      "dosage": "15 Tablets",
      "price": 20.0,
      "originalPrice": 25.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Volini Spray",
      "dosage": "40g Spray",
      "price": 150.0,
      "originalPrice": 165.0,
      "image": Icons.personal_injury,
      "color": Colors.orange,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Benadryl DR",
      "dosage": "100ml Syrup",
      "price": 120.0,
      "originalPrice": 140.0,
      "image": Icons.liquor,
      "color": Colors.red,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Pantop 40",
      "dosage": "15 Tablets",
      "price": 145.0,
      "originalPrice": 160.0,
      "image": Icons.science,
      "color": Colors.teal,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Vicks VapoRub",
      "dosage": "50g Balm",
      "price": 155.0,
      "originalPrice": 170.0,
      "image": Icons.spa,
      "color": Colors.blue.shade800,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Cetirizine",
      "dosage": "10 Tablets",
      "price": 18.0,
      "originalPrice": 22.0,
      "image": Icons.medication,
      "color": Colors.indigo,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Saridon",
      "dosage": "10 Tablets",
      "price": 40.0,
      "originalPrice": 45.0,
      "image": Icons.medication,
      "color": Colors.blue.shade400,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Combiflam",
      "dosage": "20 Tablets",
      "price": 45.0,
      "originalPrice": 52.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Limcee 500",
      "dosage": "15 Chewable Tabs",
      "price": 25.0,
      "originalPrice": 30.0,
      "image": Icons.health_and_safety,
      "color": Colors.orange,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Revital H",
      "dosage": "30 Capsules",
      "price": 280.0,
      "originalPrice": 310.0,
      "image": Icons.health_and_safety,
      "color": Colors.green,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Shelcal 500",
      "dosage": "15 Tablets",
      "price": 110.0,
      "originalPrice": 130.0,
      "image": Icons.science,
      "color": Colors.teal,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Metformin 500mg",
      "dosage": "10 Tablets",
      "price": 45.0,
      "originalPrice": 55.0,
      "image": Icons.bloodtype,
      "color": Colors.red,
      "qty": 0,
      "category": "Diabetes",
    },
    {
      "name": "Glucon-D",
      "dosage": "500g Powder",
      "price": 170.0,
      "originalPrice": 185.0,
      "image": Icons.bolt,
      "color": Colors.yellow.shade700,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Neem Face Wash",
      "dosage": "150ml",
      "price": 199.0,
      "originalPrice": 225.0,
      "image": Icons.face,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Baby Powder",
      "dosage": "200g",
      "price": 190.0,
      "originalPrice": 210.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    {
      "name": "Insulin Pen",
      "dosage": "1 Unit",
      "price": 850.0,
      "originalPrice": 950.0,
      "image": Icons.biotech,
      "color": Colors.red.shade700,
      "qty": 0,
      "category": "Diabetes",
    },
    {
      "name": "Sunscreen SPF 50",
      "dosage": "50g",
      "price": 499.0,
      "originalPrice": 550.0,
      "image": Icons.wb_sunny,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Nexium 40mg",
      "dosage": "14 Tablets",
      "price": 450.0,
      "originalPrice": 500.0,
      "image": Icons.science,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Advil 200mg",
      "dosage": "24 Liqui-Gels",
      "price": 350.0,
      "originalPrice": 380.0,
      "image": Icons.medication,
      "color": Colors.red,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Zyrtec 10mg",
      "dosage": "30 Tablets",
      "price": 550.0,
      "originalPrice": 600.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Tylenol 500mg",
      "dosage": "50 Caplets",
      "price": 420.0,
      "originalPrice": 460.0,
      "image": Icons.medication,
      "color": Colors.red,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Flonase Spray",
      "dosage": "120 Sprays",
      "price": 1200.0,
      "originalPrice": 1400.0,
      "image": Icons.personal_injury,
      "color": Colors.teal,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Centrum Adult",
      "dosage": "100 Tablets",
      "price": 1100.0,
      "originalPrice": 1300.0,
      "image": Icons.health_and_safety,
      "color": Colors.orange,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Bactine MAX",
      "dosage": "5oz Spray",
      "price": 650.0,
      "originalPrice": 720.0,
      "image": Icons.sanitizer,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Aleeve 220mg",
      "dosage": "50 Caplets",
      "price": 580.0,
      "originalPrice": 650.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Pepto-Bismol",
      "dosage": "8oz Liquid",
      "price": 480.0,
      "originalPrice": 520.0,
      "image": Icons.liquor,
      "color": Colors.pink,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "NyQuil Severe",
      "dosage": "12oz Liquid",
      "price": 950.0,
      "originalPrice": 1050.0,
      "image": Icons.liquor,
      "color": Colors.blue.shade900,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Mucinex ER",
      "dosage": "20 Tablets",
      "price": 1350.0,
      "originalPrice": 1500.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Claritin 24hr",
      "dosage": "30 Tablets",
      "price": 1600.0,
      "originalPrice": 1800.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Imodium AD",
      "dosage": "24 Caplets",
      "price": 750.0,
      "originalPrice": 820.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Preparation H",
      "dosage": "1oz Ointment",
      "price": 980.0,
      "originalPrice": 1100.0,
      "image": Icons.spa,
      "color": Colors.yellow,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Theraflu Multi",
      "dosage": "6 Packets",
      "price": 680.0,
      "originalPrice": 750.0,
      "image": Icons.medication,
      "color": Colors.orange,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Eucerin Lotion",
      "dosage": "16.9oz",
      "price": 999.0,
      "originalPrice": 1200.0,
      "image": Icons.face,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Aveeno Baby",
      "dosage": "18oz Wash",
      "price": 850.0,
      "originalPrice": 950.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    {
      "name": "Johnson Baby",
      "dosage": "15oz Oil",
      "price": 450.0,
      "originalPrice": 500.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    {
      "name": "Hydrocortisone",
      "dosage": "1oz Cream",
      "price": 250.0,
      "originalPrice": 300.0,
      "image": Icons.face,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Desitin Max",
      "dosage": "4oz Paste",
      "price": 650.0,
      "originalPrice": 720.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    // New Medicines - 30 additions
    {
      "name": "Aspirin 75mg",
      "dosage": "100 Tablets",
      "price": 85.0,
      "originalPrice": 100.0,
      "image": Icons.medication,
      "color": Colors.red,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Amoxicillin 500mg",
      "dosage": "21 Capsules",
      "price": 180.0,
      "originalPrice": 220.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Azithromycin 250mg",
      "dosage": "6 Tablets",
      "price": 120.0,
      "originalPrice": 150.0,
      "image": Icons.medication,
      "color": Colors.indigo,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Omeprazole 20mg",
      "dosage": "30 Capsules",
      "price": 95.0,
      "originalPrice": 120.0,
      "image": Icons.science,
      "color": Colors.teal,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Vitamin D3 1000IU",
      "dosage": "60 Tablets",
      "price": 250.0,
      "originalPrice": 300.0,
      "image": Icons.wb_sunny,
      "color": Colors.orange,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Omega-3 Fish Oil",
      "dosage": "90 Softgels",
      "price": 550.0,
      "originalPrice": 650.0,
      "image": Icons.health_and_safety,
      "color": Colors.blue,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Multivitamin Gummies",
      "dosage": "60 Gummies",
      "price": 380.0,
      "originalPrice": 450.0,
      "image": Icons.health_and_safety,
      "color": Colors.purple,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Biotin 10000mcg",
      "dosage": "100 Tablets",
      "price": 420.0,
      "originalPrice": 500.0,
      "image": Icons.health_and_safety,
      "color": Colors.pink,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Glucometer Kit",
      "dosage": "1 Device + 25 Strips",
      "price": 1200.0,
      "originalPrice": 1500.0,
      "image": Icons.monitor_heart,
      "color": Colors.red,
      "qty": 0,
      "category": "Diabetes",
    },
    {
      "name": "Diabetic Socks",
      "dosage": "3 Pairs",
      "price": 450.0,
      "originalPrice": 550.0,
      "image": Icons.accessibility,
      "color": Colors.grey,
      "qty": 0,
      "category": "Diabetes",
    },
    {
      "name": "Sugar-Free Sweetener",
      "dosage": "100 Sachets",
      "price": 180.0,
      "originalPrice": 220.0,
      "image": Icons.restaurant,
      "color": Colors.brown,
      "qty": 0,
      "category": "Diabetes",
    },
    {
      "name": "Baby Wipes",
      "dosage": "80 Wipes",
      "price": 120.0,
      "originalPrice": 150.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    {
      "name": "Baby Shampoo",
      "dosage": "200ml",
      "price": 220.0,
      "originalPrice": 260.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    {
      "name": "Diaper Rash Cream",
      "dosage": "100g",
      "price": 280.0,
      "originalPrice": 330.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    {
      "name": "Baby Lotion",
      "dosage": "300ml",
      "price": 350.0,
      "originalPrice": 400.0,
      "image": Icons.child_care,
      "color": Colors.purple,
      "qty": 0,
      "category": "Baby Care",
    },
    {
      "name": "Vitamin E Cream",
      "dosage": "50g",
      "price": 320.0,
      "originalPrice": 380.0,
      "image": Icons.face,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Aloe Vera Gel",
      "dosage": "200ml",
      "price": 180.0,
      "originalPrice": 220.0,
      "image": Icons.face,
      "color": Colors.green,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Anti-Acne Cream",
      "dosage": "30g",
      "price": 450.0,
      "originalPrice": 550.0,
      "image": Icons.face,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Moisturizer SPF 30",
      "dosage": "75ml",
      "price": 580.0,
      "originalPrice": 680.0,
      "image": Icons.face,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Lip Balm SPF 15",
      "dosage": "4.5g",
      "price": 120.0,
      "originalPrice": 150.0,
      "image": Icons.face,
      "color": Colors.pink,
      "qty": 0,
      "category": "Skin Care",
    },
    {
      "name": "Ciprofloxacin 500mg",
      "dosage": "10 Tablets",
      "price": 95.0,
      "originalPrice": 120.0,
      "image": Icons.medication,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Montelukast 10mg",
      "dosage": "30 Tablets",
      "price": 280.0,
      "originalPrice": 340.0,
      "image": Icons.medication,
      "color": Colors.indigo,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Losartan 50mg",
      "dosage": "30 Tablets",
      "price": 180.0,
      "originalPrice": 220.0,
      "image": Icons.favorite,
      "color": Colors.red,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Atorvastatin 20mg",
      "dosage": "30 Tablets",
      "price": 220.0,
      "originalPrice": 280.0,
      "image": Icons.favorite,
      "color": Colors.red,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Levothyroxine 100mcg",
      "dosage": "30 Tablets",
      "price": 85.0,
      "originalPrice": 110.0,
      "image": Icons.science,
      "color": Colors.teal,
      "qty": 0,
      "category": "Essentials",
    },
    {
      "name": "Probiotic Capsules",
      "dosage": "30 Capsules",
      "price": 650.0,
      "originalPrice": 750.0,
      "image": Icons.health_and_safety,
      "color": Colors.green,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Calcium + Magnesium",
      "dosage": "60 Tablets",
      "price": 320.0,
      "originalPrice": 380.0,
      "image": Icons.health_and_safety,
      "color": Colors.teal,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Iron Supplement",
      "dosage": "30 Tablets",
      "price": 180.0,
      "originalPrice": 220.0,
      "image": Icons.health_and_safety,
      "color": Colors.brown,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Zinc 50mg",
      "dosage": "100 Tablets",
      "price": 250.0,
      "originalPrice": 300.0,
      "image": Icons.health_and_safety,
      "color": Colors.grey,
      "qty": 0,
      "category": "Vitamins",
    },
    {
      "name": "Hand Sanitizer",
      "dosage": "500ml",
      "price": 180.0,
      "originalPrice": 220.0,
      "image": Icons.sanitizer,
      "color": Colors.blue,
      "qty": 0,
      "category": "Essentials",
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredMedicines = List.from(_medicines);
  }

  void _filterMedicines() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isNotEmpty) {
        // Global search: ignore category
        _filteredMedicines = _medicines.where((m) {
          return m['name'].toLowerCase().contains(query);
        }).toList();
      } else {
        // Respect category filter when not searching
        _filteredMedicines = _medicines.where((m) {
          return _selectedCategory == "All" ||
              m['category'] == _selectedCategory;
        }).toList();
      }
    });
  }

  void _syncCartTotals() {
    setState(() {
      _cartItemCount = 0;
      _cartTotal = 0;
      for (var m in _medicines) {
        _cartItemCount += (m['qty'] as int);
        _cartTotal += (m['qty'] as int) * (m['price'] as double);
      }
    });
  }

  void _addToCart(int index) {
    // We need to find the correct index in the original _medicines list
    final medicineName = _filteredMedicines[index]['name'];
    final originalIndex = _medicines.indexWhere(
      (m) => m['name'] == medicineName,
    );

    setState(() {
      _medicines[originalIndex]['qty']++;
      _cartItemCount++;
      _cartTotal += _medicines[originalIndex]['price'];
    });
  }

  void _removeFromCart(int index) {
    final medicineName = _filteredMedicines[index]['name'];
    final originalIndex = _medicines.indexWhere(
      (m) => m['name'] == medicineName,
    );

    if (_medicines[originalIndex]['qty'] > 0) {
      setState(() {
        _medicines[originalIndex]['qty']--;
        _cartItemCount--;
        _cartTotal -= _medicines[originalIndex]['price'];
      });
    }
  }

  void _viewCart() async {
    final cartItems = _medicines.where((m) => m['qty'] > 0).toList();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartScreen(cartItems: cartItems)),
    );

    if (result != null) {
      // Re-calculate totals if we return with a new state (e.g., cleared cart)
      setState(() {
        _cartItemCount = 0;
        _cartTotal = 0;
        for (var m in _medicines) {
          // If result is empty, it means order was placed (mock)
          if (result.isEmpty) {
            m['qty'] = 0;
          }
          _cartItemCount += (m['qty'] as int);
          _cartTotal += (m['qty'] as int) * (m['price'] as double);
        }
        _filterMedicines();
      });
    }
  }

  void _handlePrescriptionUpload() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.teal),
            SizedBox(height: 20),
            Text(
              "Uploading Prescription...",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Our pharmacists will review it shortly.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );

    // Mock upload delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Prescription uploaded successfully!"),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  Widget _buildPrescriptionUpload() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade400, Colors.teal.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order with Prescription",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Upload receipt and we'll find\nthe medicines for you.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _handlePrescriptionUpload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Upload Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Shop'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 100, // Space for Cart Bar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Global Search Bar
                GestureDetector(
                  onTap: () async {
                    final List<Map<String, dynamic>>? updatedAllMeds =
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MedicineSearchScreen(
                              allMedicines: _medicines,
                              categoryName: "All",
                            ),
                          ),
                        );

                    if (updatedAllMeds != null) {
                      setState(() {
                        for (var updated in updatedAllMeds) {
                          final index = _medicines.indexWhere(
                            (m) => m['name'] == updated['name'],
                          );
                          if (index != -1) {
                            _medicines[index]['qty'] = updated['qty'];
                          }
                        }
                        _syncCartTotals();
                        _filterMedicines();
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey.shade400),
                        const SizedBox(width: 12),
                        Text(
                          "Search for medicines...",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Prescription Upload
                if (_searchController.text.isEmpty) ...[
                  _buildPrescriptionUpload(),
                  const SizedBox(height: 32),
                ],

                // Categories
                if (_searchController.text.isEmpty) ...[
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryItem(
                          context,
                          "All",
                          Icons.grid_view,
                          Colors.teal,
                        ),
                        _buildCategoryItem(
                          context,
                          "Essentials",
                          Icons.medical_services,
                          Colors.blue,
                        ),
                        _buildCategoryItem(
                          context,
                          "Vitamins",
                          Icons.wb_sunny,
                          Colors.orange,
                        ),
                        _buildCategoryItem(
                          context,
                          "Diabetes",
                          Icons.bloodtype,
                          Colors.red,
                        ),
                        _buildCategoryItem(
                          context,
                          "Baby Care",
                          Icons.child_care,
                          Colors.purple,
                        ),
                        _buildCategoryItem(
                          context,
                          "Skin Care",
                          Icons.face,
                          Colors.pink,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Popular Medicines
                Text(
                  _searchController.text.isNotEmpty
                      ? "Search Results"
                      : _selectedCategory == "All"
                      ? "Popular Medicines"
                      : "$_selectedCategory Medicines",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                if (_filteredMedicines.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text(
                        "No medicines found",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredMedicines.length,
                    itemBuilder: (context, index) {
                      return _buildMedicineItem(context, index);
                    },
                  ),
              ],
            ),
          ),

          // Cart Summary Bar (Zomato Style)
          if (_cartItemCount > 0)
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: _viewCart,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$_cartItemCount ITEMS",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹${_cartTotal.toStringAsFixed(0)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        "View Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_right_alt, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () async {
        final List<Map<String, dynamic>> categoryMedicines = title == "All"
            ? _medicines
            : _medicines.where((m) => m['category'] == title).toList();

        final List<Map<String, dynamic>>? updatedMeds = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryDetailScreen(
              categoryName: title,
              medicines: categoryMedicines,
              icon: icon,
              color: color,
            ),
          ),
        );

        if (updatedMeds != null) {
          setState(() {
            for (var updated in updatedMeds) {
              final index = _medicines.indexWhere(
                (m) => m['name'] == updated['name'],
              );
              if (index != -1) {
                _medicines[index]['qty'] = updated['qty'];
              }
            }
            // Re-calculate cart stats
            _cartItemCount = 0;
            _cartTotal = 0;
            for (var m in _medicines) {
              _cartItemCount += (m['qty'] as int);
              _cartTotal += (m['qty'] as int) * (m['price'] as double);
            }
            _filterMedicines();
          });
        }
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineItem(BuildContext context, int index) {
    var item = _filteredMedicines[index];

    return GestureDetector(
      onTap: () async {
        final updated = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MedicineDetailScreen(medicine: item),
          ),
        );
        if (updated != null) {
          setState(() {
            final mainIndex = _medicines.indexWhere(
              (m) => m['name'] == updated['name'],
            );
            if (mainIndex != -1) {
              _medicines[mainIndex]['qty'] = updated['qty'];
            }
            _syncCartTotals();
            _filterMedicines();
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Hero(
                tag: 'med_${item['name']}',
                child: Icon(
                  item['image'] as IconData,
                  color: item['color'] as Color,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['dosage'],
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "₹${item['price']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "₹${item['originalPrice']}",
                        style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Add Button
            Column(
              children: [
                if (item['qty'] == 0)
                  SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        elevation: 0,
                        side: const BorderSide(color: Colors.teal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text("ADD"),
                    ),
                  )
                else
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _removeFromCart(index),
                          icon: const Icon(
                            Icons.remove,
                            size: 16,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 32),
                        ),
                        Text(
                          "${item['qty']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _addToCart(index),
                          icon: const Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(minWidth: 32),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
