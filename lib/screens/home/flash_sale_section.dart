// lib/widgets/flash_sale_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/flashsale_provider.dart';

/// Model untuk 1 item flash sale
class FlashItem {
  final String image;
  final String badge;
  final String title;
  final String price;
  final String oldPrice;
  final VoidCallback? onTap;

  FlashItem({
    required this.image,
    this.badge = '',
    this.title = '',
    this.price = '',
    this.oldPrice = '',
    this.onTap,
  });
}

class FlashSaleSection extends ConsumerWidget {
  const FlashSaleSection({super.key});
  String two(int n) => n.toString().padLeft(2, '0');

  static final List<FlashItem> items = [
    FlashItem(
      image: 'assets/brands/hp1.png',
      badge: 'Diskon 50%',
      title: 'Headphone redmi note 9 pro',
      price: 'Rp 1.299.000',
      oldPrice: 'Rp 2.598.000',
    ),
    FlashItem(
      image: 'assets/brands/hp2.png',
      badge: 'Flash Deal',
      title: 'Speaker Bluetooth',
      price: 'Rp 899.000',
      oldPrice: 'Rp 1.499.000',
    ),
    FlashItem(
      image: 'assets/brands/hp3.png',
      badge: 'Hot 30%',
      title: 'Powerbank 20k',
      price: 'Rp 249.000',
      oldPrice: 'Rp 349.000',
    ),
    FlashItem(
      image: 'assets/brands/hp4.png',
      badge: 'Cicilan 0%',
      title: 'Apple Watch',
      price: 'Rp 1.050.000',
      oldPrice: 'Rp 1.500.000',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(flashSaleCountdownProvider);
    final h = two(d.inHours);
    final m = two(d.inMinutes % 60);
    final s = two(d.inSeconds % 60);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFFFA726), Color(0xFFF4511E)]),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // ===== header row =====
            Row(
              children: [
                const Icon(Icons.flash_on, color: Colors.white),
                const SizedBox(width: 8),

                // gunakan Flexible agar teks tidak memaksa Row melebar
                const Flexible(
                  child: Text(
                    'Flash Sale',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    '$h : $m : $s',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ===== horizontal list =====
            SizedBox(
              height: 140,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 4), // beri padding supaya tidak overflow di kanan
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final it = items[i];
                  return SizedBox(
                    width: 140,
                    child: GestureDetector(
                      onTap: it.onTap,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        clipBehavior: Clip.hardEdge, // pastikan child tidak keluar
                        child: Column(
                          children: [
                            // gambar (bagian atas) - background cover + foreground contain
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned.fill(
                                      child: Image.asset(
                                        it.image,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                                      ),
                                    ),
                                    Positioned.fill(child: Container(color: Colors.black.withOpacity(0.08))),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                                        child: Image.asset(
                                          it.image,
                                          fit: BoxFit.contain,
                                          width: 120,
                                          height: 80,
                                          errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                                        ),
                                      ),
                                    ),
                                    if (it.badge.isNotEmpty)
                                      Positioned(
                                        left: 8,
                                        top: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.6),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            it.badge,
                                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),

                            // info (bagian bawah)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(it.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(it.price, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 6),
                                      if (it.oldPrice.isNotEmpty)
                                        Flexible(
                                          child: Text(
                                            it.oldPrice,
                                            style: TextStyle(color: Colors.grey.shade600, decoration: TextDecoration.lineThrough, fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
