import 'package:flutter/material.dart';

class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final Offset beginOffset;
  final Duration duration;
  final Curve curve;
  final bool autoPlay;

  const SlideInAnimation({
    super.key,
    required this.child,
    this.beginOffset = const Offset(0, 1),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.autoPlay = true,
  });

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    if (widget.autoPlay) {
      _controller.forward();
    }
  }

  void play() => _controller.forward();
  void reverse() => _controller.reverse();
  void reset() => _controller.reset();

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}