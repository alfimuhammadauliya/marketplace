import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/category_provider.dart';

class CategoryPills extends ConsumerWidget {
  const CategoryPills({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(categoryIndexProvider);

    final categories = [
      {'icon': Icons.phone_iphone, 'label': 'Smartphone'},
      {'icon': Icons.laptop_mac, 'label': 'Laptop'},
      {'icon': Icons.headphones, 'label': 'Aksesoris'},
      {'icon': Icons.watch, 'label': 'Smartwatch'},
      {'icon': Icons.tablet_mac, 'label': 'Tablet'},
    ];

    return SizedBox(
      height: 62,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final isActive = i == active;

          return GestureDetector(
            onTap: () => ref.read(categoryIndexProvider.notifier).state = i,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF161616) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive ? Colors.white : Colors.grey.shade300,
                  width: 1.3,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: isActive ? 1.25 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      categories[i]['icon'] as IconData,
                      color: isActive ? Colors.white : Colors.black87,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    categories[i]['label'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: isActive ? Colors.white : Colors.black87,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}