import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<ProductModel>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<ProductModel>> {
  CartNotifier() : super([]);

  void add(ProductModel product) {
    state = [...state, product];
  }

  void remove(ProductModel product) {
    state = state.where((item) => item.id != product.id).toList();
  }
}
