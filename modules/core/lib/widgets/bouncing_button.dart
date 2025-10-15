import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  static const Duration DEFAULT_ANIMATION_DURATION = Duration(milliseconds: 200);
  static const double DEFAULT_SCALE_DOWN_FACTOR = 0.95;
  static const double DEFAULT_SCALE_UP_FACTOR = 1.1;

  const BouncingButton._({
    super.key,
    this.onTap,
    required this.animationDuration,
    required this.scaleFactor,
    required this.child,
  });

  factory BouncingButton.scaleDown({
    Key? key,
    VoidCallback? onTap,
    Duration animationDuration = DEFAULT_ANIMATION_DURATION,
    double scaleFactor = DEFAULT_SCALE_DOWN_FACTOR,
    required Widget child,
  }) {
    return BouncingButton._(
      key: key,
      onTap: onTap,
      animationDuration: animationDuration,
      scaleFactor: scaleFactor,
      child: child,
    );
  }

  factory BouncingButton.scaleUp({
    Key? key,
    VoidCallback? onTap,
    Duration animationDuration = DEFAULT_ANIMATION_DURATION,
    double scaleFactor = DEFAULT_SCALE_UP_FACTOR,
    required Widget child,
  }) {
    return BouncingButton._(
      key: key,
      onTap: onTap,
      animationDuration: animationDuration,
      scaleFactor: scaleFactor,
      child: child,
    );
  }

  final VoidCallback? onTap;
  final Duration animationDuration;
  final double scaleFactor;
  final Widget child;

  @override
  State<BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton> with TickerProviderStateMixin {
  final Stopwatch stopwatch = Stopwatch();
  late AnimationController _controller;

  bool get isScaleDown => widget.scaleFactor < 1.0;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BouncingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration || widget.scaleFactor != oldWidget.scaleFactor) {
      initController();
    }
  }

  void initController() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      lowerBound: isScaleDown ? widget.scaleFactor : 1.0,
      upperBound: isScaleDown ? 1.0 : widget.scaleFactor,
      value: 1.0,
    );
  }

  void onTapDown() {
    stopwatch.start();
    if (isScaleDown) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void onTapUp({bool handleOnTap = true}) async {
    final int endtime = stopwatch.elapsedMilliseconds;
    if (endtime < 100) {
      await Future.delayed(Duration(milliseconds: 100 - endtime));
    }
    if (isScaleDown) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (handleOnTap) widget.onTap?.call();
    stopwatch
      ..stop()
      ..reset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        onTapDown();
      },
      onTapUp: (details) {
        onTapUp();
      },
      onTapCancel: () {
        onTapUp(handleOnTap: false);
      },
      child: ScaleTransition(
        scale: _controller,
        child: widget.child,
      ),
    );
  }
}
