import 'package:flutter/material.dart';

class FloatingCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FloatingCartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.orangeAccent,
      child: const Icon(Icons.shopping_cart),
    );
  }
}
