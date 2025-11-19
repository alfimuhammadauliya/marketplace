import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

final productProvider = Provider<List<ProductModel>>((ref) {
  return [
    ProductModel(
      id: "1",
      name: "Macbook",
      image: "assets/brands/mac.png",
      price: 1499000,
    ),
    ProductModel(
      id: "2",
      name: "Samsung S24",
      image: "assets/brands/samsung.png",
      price: 1799000,
    ),
    ProductModel(
      id: "3",
      name: "Redmi Note 13pro 5G",
      image: "assets/brands/xiaomi.png",
      price: 4999000,
    ),
    ProductModel(
      id: "4",
      name: "Laptop Lenovo Thinkpad",
      image: "assets/brands/thinkpad.png",
      price: 6099000,
    ),
  ];
});
