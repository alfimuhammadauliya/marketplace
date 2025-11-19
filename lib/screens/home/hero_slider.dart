// lib/widgets/hero_slider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/providers/slider_provider.dart';

/// Model slide agar setiap slide punya data sendiri
class SlideItem {
  final String image;
  final String badge;
  final String title;
  final String price;
  final VoidCallback? onBuy;

  SlideItem({
    required this.image,
    this.badge = '',
    this.title = '',
    this.price = '',
    this.onBuy,
  });
}

class HeroSlider extends ConsumerStatefulWidget {
  const HeroSlider({super.key});

  @override
  ConsumerState<HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends ConsumerState<HeroSlider> {
  late final PageController _pageController;
  Timer? _timer;

  // --- Isi data slide di sini, tiap slide berbeda ---
  final List<SlideItem> slides = [
    SlideItem(
      image: 'assets/brands/bannerIP1.jpeg',
      badge: '15% OFF',
      title: 'iPhone 16\nPro Max',
      price: 'Rp 21.999.000',
      onBuy: () { /* aksi beli2 slide 1 */ },
    ),
    SlideItem(
      image: 'assets/brands/banner14.png',
      badge: 'Diskon Spesial',
      title: 'iPhone 14\nPro Max',
      price: 'Rp 18.499.000',
      onBuy: () { /* aksi beli slide 2 */ },
    ),
    SlideItem(
      image: 'assets/brands/banner13.png',
      badge: 'Cicilan 0%',
      title: 'iPhone 13\nMini',
      price: 'Rp 9.999.000',
      onBuy: () { /* aksi beli slide 3 */ },
    ),
  ];
  // ---------------------------------------------------

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92, initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        final cur = ref.read(sliderIndexProvider);
        final next = (cur + 1) % slides.length;
        ref.read(sliderIndexProvider.notifier).state = next;
        if (mounted && _pageController.hasClients) {
          _pageController.animateToPage(next,
              duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    final target = (page % slides.length + slides.length) % slides.length;
    ref.read(sliderIndexProvider.notifier).state = target;
    if (_pageController.hasClients) {
      _pageController.animateToPage(target,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final idx = ref.watch(sliderIndexProvider);

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (i) => ref.read(sliderIndexProvider.notifier).state = i,
                itemBuilder: (context, i) {
                  final item = slides[i]; // ambil data slide ke-i
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.hasClients && _pageController.position.haveDimensions) {
                        final page = (_pageController.page ?? _pageController.initialPage.toDouble());
                        final diff = (page - i).abs();
                        value = (1 - (diff * 0.14)).clamp(0.86, 1.0).toDouble();
                      }
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          children: [
                            // === Opsi C: Background terisi (cover, darkened) + gambar utama contain ===
                            Positioned.fill(
                              child: Stack(
                                children: [
                                  // Background: same image, cover, dark overlay supaya rapi
                                  Positioned.fill(
                                    child: Image.asset(
                                      item.image,
                                      fit: BoxFit.cover,
                                      // darken supaya teks di atas tetap terbaca
                                      color: Colors.black.withOpacity(0.35),
                                      colorBlendMode: BlendMode.darken,
                                      errorBuilder: (c, e, s) => Container(
                                        color: Colors.grey[300],
                                        child: const Center(child: Icon(Icons.image_not_supported)),
                                      ),
                                    ),
                                  ),
                                  // Gambar utama: tidak terpotong, berada di tengah dengan contain
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Image.asset(
                                        item.image,
                                        fit: BoxFit.contain,
                                        errorBuilder: (c, e, s) => Container(
                                          color: Colors.grey[300],
                                          child: const Center(child: Icon(Icons.image_not_supported)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // konten teks spesifik per slide
                            Positioned(
                              left: 12,
                              bottom: 18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item.badge.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        item.badge,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.price,
                                    style: const TextStyle(
                                      color: Colors.yellowAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: item.onBuy,
                                    child: const Text('Beli Sekarang'),
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

              // panah kiri
              Positioned(
                left: 6,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Material(
                    color: Colors.black.withOpacity(0.25),
                    shape: const CircleBorder(),
                    child: IconButton(
                      padding: const EdgeInsets.all(8),
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        final cur = ref.read(sliderIndexProvider);
                        final prev = (cur - 1) < 0 ? slides.length - 1 : cur - 1;
                        _goToPage(prev);
                      },
                    ),
                  ),
                ),
              ),

              // panah kanan
              Positioned(
                right: 6,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Material(
                    color: Colors.black.withOpacity(0.25),
                    shape: const CircleBorder(),
                    child: IconButton(
                      padding: const EdgeInsets.all(8),
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: Colors.white,
                      onPressed: () {
                        final cur = ref.read(sliderIndexProvider);
                        final next = (cur + 1) % slides.length;
                        _goToPage(next);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(slides.length, (i) {
            final active = i == idx;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active ? Colors.white : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
      ],
    );
  }
}
