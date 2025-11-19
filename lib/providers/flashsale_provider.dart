import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flashSaleCountdownProvider =
    StateNotifierProvider<FlashSaleNotifier, Duration>((ref) => FlashSaleNotifier());

class FlashSaleNotifier extends StateNotifier<Duration> {
  Timer? _timer;
  FlashSaleNotifier() : super(const Duration(hours: 2, minutes: 0, seconds: 0)) {
    _start();
  }
  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (state.inSeconds > 0) {
        state = Duration(seconds: state.inSeconds - 1);
      } else {
        _timer?.cancel();
      }
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
