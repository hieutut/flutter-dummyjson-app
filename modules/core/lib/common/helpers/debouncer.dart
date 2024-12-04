import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Debouncer({this.duration = const Duration(milliseconds: 300)});

  final Duration duration;

  Timer? _timer;

  void trigger(VoidCallback callback, {Duration? debounceDuration}) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(debounceDuration ?? duration, callback);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  static final Debouncer singleton = Debouncer();
}

class TapDebouncer extends Debouncer {
  TapDebouncer({super.duration});

  final ValueNotifier<bool> canTapNotifier = ValueNotifier(true);

  @override
  void trigger(VoidCallback callback, {Duration? debounceDuration}) {
    if (!canTapNotifier.value) return;
    canTapNotifier.value = false;
    callback();
    _timer = Timer(
      debounceDuration ?? duration,
      () => canTapNotifier.value = true,
    );
  }

  static final TapDebouncer singleton = TapDebouncer();
}

// Experience
class DebouncerButton extends StatelessWidget {
  const DebouncerButton({
    super.key,
    required this.onTap,
    required this.builder,
  });

  final VoidCallback onTap;
  final Widget Function(bool canTap) builder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => TapDebouncer.singleton.trigger(onTap),
      child: ValueListenableBuilder<bool>(
        valueListenable: TapDebouncer.singleton.canTapNotifier,
        builder: (context, canTap, child) => builder(canTap),
      ),
    );
  }
}
