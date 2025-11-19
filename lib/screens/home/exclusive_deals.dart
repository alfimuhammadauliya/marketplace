import 'package:flutter/material.dart';

class ExclusiveDeals extends StatelessWidget {
  const ExclusiveDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Penawaran Eksklusif',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          _buildExclusiveCard(
            image: 'assets/brands/iphone12.png',
            title: 'Diskon Spesial Hari Ini!',
            subtitle: 'Dapatkan penawaran terbaik hanya untukmu',
          ),

          const SizedBox(height: 16),

          _buildExclusiveCard(
            image: 'assets/brands/samsung53.png',
            title: 'Promo Produk Terbaru',
            subtitle: 'Belanja hemat dan dapatkan cashback',
          ),
        ],
      ),
    );
  }

  // =============================
  // CARD PREMIUM (ANTI TERPOTONG)
  // =============================
  Widget _buildExclusiveCard({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // BACKGROUND agar kotak tetap penuh
            Positioned.fill(
              child: Image.asset(
                image,
                fit: BoxFit.cover, // dipakai hanya untuk background
                opacity: const AlwaysStoppedAnimation(0.25), // redup agar tidak ganggu teks
              ),
            ),

            // GAMBAR UTAMA (TIDAK TERPOTONG)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  width: 200,
                  height: 140,
                ),
              ),
            ),

            // GRADIENT GELAP BAWAH
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
            ),

            // TEKS + TOMBOL
            Positioned(
              left: 16,
              right: 16,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Lihat Detail",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
