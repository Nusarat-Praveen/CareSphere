import 'package:flutter/material.dart';
import 'medicine_detail_screen.dart';
import 'medicine_search_screen.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryName;
  final List<Map<String, dynamic>> medicines;
  final IconData icon;
  final Color color;

  const CategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.medicines,
    required this.icon,
    required this.color,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late List<Map<String, dynamic>> _localMedicines;

  @override
  void initState() {
    super.initState();
    _localMedicines = List.from(widget.medicines);
  }

  void _updateQty(int index, int delta) {
    setState(() {
      _localMedicines[index]['qty'] += delta;
      if (_localMedicines[index]['qty'] < 0) _localMedicines[index]['qty'] = 0;
    });
  }

  String _getCategoryTip() {
    switch (widget.categoryName) {
      case "All":
        return "Explore our wide range of medicines for all your health needs.";
      case "Essentials":
        return "Keep these basics handy for minor health needs.";
      case "Vitamins":
        return "Combine these with a balanced diet for best results.";
      case "Diabetes":
        return "Monitor your levels regularly and stay active.";
      case "Baby Care":
        return "Use gentle, dermatologist-tested products for babies.";
      case "Skin Care":
        return "Consistency is key to healthy, glowing skin.";
      default:
        return "Quality health care at your fingertips.";
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
                widget.categoryName,
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
              onPressed: () => Navigator.pop(context, _localMedicines),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                ),
                              ),
                              Text(
                                _getCategoryTip(),
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

                  // Category-Specific Search Bar
                  GestureDetector(
                    onTap: () async {
                      final List<Map<String, dynamic>>? updatedMeds =
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MedicineSearchScreen(
                                allMedicines: _localMedicines,
                                categoryName: widget.categoryName,
                              ),
                            ),
                          );

                      if (updatedMeds != null) {
                        setState(() {
                          _localMedicines = List.from(updatedMeds);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).shadowColor.withOpacity(0.04),
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
                            widget.categoryName == "All"
                                ? "Search for medicines..."
                                : "Search in ${widget.categoryName}...",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    "All ${widget.categoryName}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = _localMedicines[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: _buildProductTile(item, index),
              );
            }, childCount: _localMedicines.length),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildProductTile(Map<String, dynamic> item, int index) {
    final bool isInCart = item['qty'] > 0;
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
            _localMedicines[index]['qty'] = updated['qty'];
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Hero(
                tag: 'med_${item['name']}',
                child: Icon(item['image'], color: item['color'], size: 35),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    item['dosage'],
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "₹${item['price'].toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "₹${item['originalPrice'].toStringAsFixed(0)}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                if (!isInCart)
                  ElevatedButton(
                    onPressed: () => _updateQty(index, 1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade50,
                      foregroundColor: Colors.teal,
                      elevation: 0,
                      minimumSize: const Size(80, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.teal),
                      ),
                    ),
                    child: const Text(
                      "ADD",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () => _updateQty(index, -1),
                        ),
                        Text(
                          "${item['qty']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () => _updateQty(index, 1),
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
