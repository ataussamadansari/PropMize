import 'package:flutter/material.dart';

class AnimatedBuilderWidget extends StatefulWidget {
  final Widget Function(BuildContext, Animation<double>, Widget?) builder;
  final Duration duration;
  final Curve curve;
  final bool autoPlay;

  const AnimatedBuilderWidget({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.autoPlay = true,
  });

  @override
  State<AnimatedBuilderWidget> createState() => _AnimatedBuilderWidgetState();
}

class _AnimatedBuilderWidgetState extends State<AnimatedBuilderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (widget.autoPlay) {
      _controller.forward();
    }
  }

  void play() => _controller.forward();
  void reverse() => _controller.reverse();
  void reset() => _controller.reset();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => widget.builder(context, _animation, child),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}