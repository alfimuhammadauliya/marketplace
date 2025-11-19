import 'package:flutter/material.dart';

// Home components
import 'header.dart';
import 'hero_slider.dart';
import 'category_pills.dart';
import 'flash_sale_section.dart';
import 'featured_products.dart';
import 'premium_brands.dart';
import 'exclusive_deals.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // Safe area untuk notch / status bar
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 12),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔍 Search + Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Header(),
              ),

              const SizedBox(height: 12),

              // 🖼 Hero Slider
              HeroSlider(),
              const SizedBox(height: 16),

              // 📂 Category Pills
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: CategoryPills(),
              ),
              const SizedBox(height: 20),

              // ⚡ Flash Sale
              FlashSaleSection(),
              const SizedBox(height: 20),

              // ⭐ Featured Products
              FeaturedProducts(),
              const SizedBox(height: 20),

              // 🏷 Premium Brands (4x4 grid)
              PremiumBrands(),
              const SizedBox(height: 20),

              // 🔥 Exclusive Deals
              ExclusiveDeals(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
