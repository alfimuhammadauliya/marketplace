// lib/widgets/premium_brands.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PremiumBrands extends StatefulWidget {
  const PremiumBrands({super.key});

  @override
  State<PremiumBrands> createState() => _PremiumBrandsState();
}

class _PremiumBrandsState extends State<PremiumBrands> {
  final List<String> logos = const [
    'assets/brands/b1.png',
    'assets/brands/b2.png',
    'assets/brands/be.png',
    'assets/brands/b4.png',
    'assets/brands/b5.png',
    'assets/brands/b6.png',
    'assets/brands/b7.png',
    'assets/brands/b8.png',
  ];

  int? _activeIndex;
  static const double _zoom = 1.08;
  static const Duration _dur = Duration(milliseconds: 160);

  void _setActive(int? idx) {
    if (!mounted) return;
    setState(() => _activeIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    const double sidePadding = 16;
    const double spacing = 12;

    final width = MediaQuery.of(context).size.width;
    final available = width - sidePadding * 2 - spacing * 3;
    final itemSize = (available / 4).clamp(56.0, 120.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Brand Premium', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(logos.length, (index) {
              final logo = logos[index];
              final active = _activeIndex == index;

              Widget avatar = AnimatedContainer(
                duration: _dur,
                curve: Curves.easeOut,
                width: itemSize,
                height: itemSize,
                child: AnimatedScale(
                  scale: active ? _zoom : 1.0,
                  duration: _dur,
                  curve: Curves.easeOut,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          // <-- tidak menggunakan const di sini
                          color: Colors.black.withOpacity(active ? 0.18 : 0.08),
                          blurRadius: active ? 12 : 6,
                          offset: Offset(0, active ? 6 : 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        logo,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Center(child: Icon(Icons.image_not_supported, color: Colors.grey.shade400)),
                      ),
                    ),
                  ),
                ),
              );

              if (kIsWeb ||
                  [
                    TargetPlatform.macOS,
                    TargetPlatform.windows,
                    TargetPlatform.linux,
                  ].contains(Theme.of(context).platform)) {
                avatar = MouseRegion(
                  onEnter: (_) => _setActive(index),
                  onExit: (_) => _setActive(null),
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTapDown: (_) => _setActive(index),
                    onTapUp: (_) => _setActive(null),
                    onTapCancel: () => _setActive(null),
                    onTap: () {
                      // klik brand
                    },
                    child: avatar,
                  ),
                );
              } else {
                avatar = GestureDetector(
                  onTapDown: (_) => _setActive(index),
                  onTapUp: (_) => _setActive(null),
                  onTapCancel: () => _setActive(null),
                  onTap: () {
                    // ketuk brand
                  },
                  child: avatar,
                );
              }

              return avatar;
            }),
          ),
        ],
      ),
    );
  }
}
