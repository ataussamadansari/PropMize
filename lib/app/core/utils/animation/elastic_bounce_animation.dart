import 'package:flutter/material.dart';

class ElasticBounceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ElasticBounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<ElasticBounceAnimation> createState() => _ElasticBounceAnimationState();
}

class _ElasticBounceAnimationState extends State<ElasticBounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}