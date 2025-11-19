import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String price; // harus String
  final String image;
  int qty;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.qty = 1,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 🔹 Item keranjang (beragam, tidak semua Samsung)
  final List<CartItem> cartItems = [
    CartItem(
      name: "iPhone 17 Pro Max",
      price: "Rp 28.999.000",
      image: "assets/brands/iphone17.png",
      qty: 1,
    ),
    CartItem(
      name: "Samsung S25 Ultra",
      price: "Rp 21.499.000",
      image: "assets/brands/samsung25.png",
      qty: 2,
    ),
    CartItem(
      name: "Xiaomi 15 Pro",
      price: "Rp 12.899.000",
      image: "assets/brands/xiaomi15.png",
      qty: 1,
    ),
  ];

  // 🔹 Hitung total aman tanpa error "replaceAll undefined"
  String getTotal() {
    int total = 0;

    for (var item in cartItems) {
      final hargaStr = item.price; // sudah aman, bukan null

      String cleaned = hargaStr.replaceAll(RegExp(r'[^0-9]'), '');
      int harga = int.tryParse(cleaned) ?? 0;

      total += harga * item.qty;
    }

    // Format angka menjadi Rupiah
    return "Rp ${total.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => "${m[1]}.",
    )}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                // FOTO PRODUK
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // INFO PRODUK
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(item.price,
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),

                // + - QTY
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (item.qty > 1) item.qty--;
                        });
                      },
                    ),
                    Text("${item.qty}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          item.qty++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),

      // FOOTER TOTAL
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: ${getTotal()}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: () {},
              child: const Text("Checkout", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
