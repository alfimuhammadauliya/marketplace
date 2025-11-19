import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider sederhana untuk menyimpan index slider saat ini.
final sliderIndexProvider = StateProvider<int>((ref) => 0);
