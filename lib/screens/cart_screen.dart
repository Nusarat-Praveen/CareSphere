import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Map<String, dynamic>> _localCartItems;
  String _selectedPaymentMethod = 'Cash on Delivery';
  String _selectedAddress = 'Home - 123, Healthcare Street, Medical City';

  String _couponCode = '';
  double _couponDiscount = 0.0;
  String? _appliedCoupon;

  final List<Map<String, dynamic>> _availableCoupons = [
    {'code': 'CARE10', 'desc': 'Get ₹50 off on orders above ₹300'},
    {'code': 'HEALTH20', 'desc': 'Get ₹100 off on orders above ₹600'},
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Cash on Delivery', 'icon': Icons.money},
    {'name': 'UPI (GPay, PhonePe)', 'icon': Icons.account_balance_wallet},
    {'name': 'Credit / Debit Card', 'icon': Icons.credit_card},
  ];

  double get _deliveryFee => _subtotal > 200 ? 0.0 : 40.0;
  final double _baseDiscount = 50.0;

  bool get _isGiftEligible => _subtotal > 500;

  @override
  void initState() {
    super.initState();
    _localCartItems = List.from(widget.cartItems);
  }

  double get _subtotal {
    return _localCartItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['qty']),
    );
  }

  double get _totalDiscount => _baseDiscount + _couponDiscount;

  double get _total {
    double val = _subtotal + _deliveryFee - _totalDiscount;
    return val > 0 ? val : 0;
  }

  void _updateQty(int index, int delta) {
    setState(() {
      _localCartItems[index]['qty'] += delta;
      if (_localCartItems[index]['qty'] <= 0) {
        _localCartItems.removeAt(index);
      }
    });
  }

  void _applyCoupon(String code) {
    setState(() {
      if (code == 'CARE10') {
        if (_subtotal >= 300) {
          _couponDiscount = 50.0;
          _appliedCoupon = code;
          _showToast("Coupon CARE10 applied!");
        } else {
          _showToast("CARE10 requires min. order of ₹300", isError: true);
        }
      } else if (code == 'HEALTH20') {
        if (_subtotal >= 600) {
          _couponDiscount = 100.0;
          _appliedCoupon = code;
          _showToast("Coupon HEALTH20 applied!");
        } else {
          _showToast("HEALTH20 requires min. order of ₹600", isError: true);
        }
      } else {
        _showToast("Invalid Coupon Code", isError: true);
      }
    });
  }

  void _showToast(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.teal,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleChangeAddress() {
    showDialog(
      context: context,
      builder: (context) {
        String newAddress = _selectedAddress;
        return AlertDialog(
          title: const Text("Change Address"),
          content: TextField(
            onChanged: (val) => newAddress = val,
            decoration: const InputDecoration(hintText: "Enter full address"),
            controller: TextEditingController(text: _selectedAddress),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => _selectedAddress = newAddress);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _localCartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                if (_subtotal <= 200) _buildDeliveryHint(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildAddressSection(),
                      const SizedBox(height: 24),

                      if (_isGiftEligible) _buildFreeGiftCard(),

                      const Text(
                        "Items in Cart",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(_localCartItems.length, (index) {
                        final item = _localCartItems[index];
                        return _buildCartItem(item, index);
                      }),
                      const SizedBox(height: 24),

                      _buildCouponSection(),

                      const SizedBox(height: 32),
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._paymentMethods.map(
                        (method) => _buildPaymentTile(method),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                _buildOrderSummary(),
              ],
            ),
      bottomNavigationBar: _localCartItems.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    String msg =
                        'Order placed for $_selectedAddress via $_selectedPaymentMethod!';
                    if (_isGiftEligible) {
                      msg += "\nFree Hand Sanitizer included!";
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(msg),
                        backgroundColor: Colors.teal,
                        duration: const Duration(seconds: 4),
                      ),
                    );
                    Navigator.pop(context, []);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Place Order • ₹${_total.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildFreeGiftCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.card_giftcard,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Free Gift Eligible!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  "A complimentary Hand Sanitizer has been added to your order.",
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Offers & Benefits",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.local_offer, color: Colors.teal, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  onChanged: (val) => _couponCode = val,
                  decoration: const InputDecoration(
                    hintText: "Enter Coupon Code",
                    border: InputBorder.none,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _applyCoupon(_couponCode),
                child: const Text(
                  "APPLY",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        if (_appliedCoupon != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 4),
            child: Text(
              "✓ Coupon $_appliedCoupon applied",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _availableCoupons.length,
            itemBuilder: (context, index) {
              final coupon = _availableCoupons[index];
              return GestureDetector(
                onTap: () => _applyCoupon(coupon['code']),
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.teal.shade100,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        coupon['code'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      Text(
                        coupon['desc'],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.teal, size: 20),
              const SizedBox(width: 8),
              const Text(
                "Delivery Address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.teal,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _handleChangeAddress,
                child: const Text(
                  "Change",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Text(
            _selectedAddress,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTile(Map<String, dynamic> method) {
    bool isSelected = _selectedPaymentMethod == method['name'];
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = method['name']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              method['icon'],
              color: isSelected ? Colors.teal : Colors.grey[600],
            ),
            const SizedBox(width: 16),
            Text(
              method['name'],
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.teal : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.teal, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryHint() {
    double remaining = 200 - _subtotal;
    return Container(
      width: double.infinity,
      color: Colors.teal.shade50,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.delivery_dining, size: 20, color: Colors.teal),
          const SizedBox(width: 8),
          Text(
            "Add ₹${remaining.toStringAsFixed(0)} more for FREE delivery",
            style: const TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            "Your cart is empty",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Go Back"),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (item['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item['image'], color: item['color'], size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "₹${item['price']} per unit",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _updateQty(index, -1),
                  icon: const Icon(Icons.remove, size: 16, color: Colors.teal),
                  constraints: const BoxConstraints(minWidth: 32),
                ),
                Text(
                  "${item['qty']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                IconButton(
                  onPressed: () => _updateQty(index, 1),
                  icon: const Icon(Icons.add, size: 16, color: Colors.teal),
                  constraints: const BoxConstraints(minWidth: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _summaryRow("Subtotal", "₹${_subtotal.toStringAsFixed(0)}"),
          _summaryRow(
            "Delivery Fee",
            _deliveryFee == 0 ? "FREE" : "₹${_deliveryFee.toStringAsFixed(0)}",
            isFree: _deliveryFee == 0,
          ),
          _summaryRow(
            "Discount",
            "-₹${_totalDiscount.toStringAsFixed(0)}",
            isDiscount: true,
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "₹${_total.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    bool isDiscount = false,
    bool isFree = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 15)),
          Text(
            value,
            style: TextStyle(
              color: (isDiscount || isFree) ? Colors.green : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
