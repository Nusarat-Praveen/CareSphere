import 'package:flutter/material.dart';
import 'medicine_detail_screen.dart';

class MedicineSearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allMedicines;
  final String categoryName;

  const MedicineSearchScreen({
    super.key,
    required this.allMedicines,
    required this.categoryName,
  });

  @override
  State<MedicineSearchScreen> createState() => _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _allMeds;
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _allMeds = List.from(widget.allMedicines);
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _allMeds.where((m) {
          return m['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _updateQty(int index, int delta) {
    setState(() {
      _searchResults[index]['qty'] += delta;
      if (_searchResults[index]['qty'] < 0) _searchResults[index]['qty'] = 0;

      // Sync back to the main list as well
      final name = _searchResults[index]['name'];
      final mainIndex = _allMeds.indexWhere((m) => m['name'] == name);
      if (mainIndex != -1) {
        _allMeds[mainIndex]['qty'] = _searchResults[index]['qty'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _allMeds),
        ),
        title: Container(
          margin: const EdgeInsets.only(right: 16),
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: widget.categoryName == "All"
                  ? "Search medications..."
                  : "Search in ${widget.categoryName}...",
              prefixIcon: const Icon(Icons.search, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    _searchController.text.isEmpty
                        ? "Search for names like 'Dolo' or 'Saridon'"
                        : "No results found for '${_searchController.text}'",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final item = _searchResults[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Hero(
                      tag: 'med_${item['name']}',
                      child: Icon(item['image'], color: item['color']),
                    ),
                  ),
                  title: Text(
                    item['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${item['dosage']} • ₹${item['price']}"),
                  trailing: _buildAddButton(item, index),
                  onTap: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MedicineDetailScreen(medicine: item),
                      ),
                    );
                    if (updated != null) {
                      setState(() {
                        _searchResults[index]['qty'] = updated['qty'];
                        // Sync to main list
                        final mainIndex = _allMeds.indexWhere(
                          (m) => m['name'] == updated['name'],
                        );
                        if (mainIndex != -1) {
                          _allMeds[mainIndex]['qty'] = updated['qty'];
                        }
                      });
                    }
                  },
                );
              },
            ),
    );
  }

  Widget _buildAddButton(Map<String, dynamic> item, int index) {
    if (item['qty'] == 0) {
      return TextButton(
        onPressed: () => _updateQty(index, 1),
        child: const Text(
          "ADD",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
      );
    }
    return Container(
      width: 80,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _updateQty(index, -1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.remove, color: Colors.white, size: 16),
            ),
          ),
          Text(
            "${item['qty']}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () => _updateQty(index, 1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
