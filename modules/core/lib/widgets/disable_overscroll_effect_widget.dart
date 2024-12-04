import 'package:flutter/material.dart';

class DisableOverscrollEffectWidget extends StatelessWidget {
  final Widget child;
  const DisableOverscrollEffectWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: child,
    );
  }
}
