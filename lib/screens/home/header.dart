import 'dart:ui';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    children: [
      Icon(Icons.search, color: Colors.grey, size: 20),
      SizedBox(width: 8),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari handphone…',
            border: InputBorder.none,
          ),
        ),
      ),
      Icon(Icons.tune, color: Colors.grey, size: 20),
    ],
  ),
)
        ),
      ),
    );
  }
}
