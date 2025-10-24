import 'package:flutter/material.dart';

mixin AnimationMixin<T extends StatefulWidget> on State<T> {
  late AnimationController controller;
  late Animation<double> animation;

  void initializeAnimation({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    TickerProvider? vsync,
  }) {
    controller = AnimationController(
      duration: duration,
      vsync: vsync ?? this as TickerProvider,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: curve,
    );
  }

  void play() => controller.forward();
  void reverse() => controller.reverse();
  void reset() => controller.reset();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}