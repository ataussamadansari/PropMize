import 'package:flutter/material.dart';

class BounceAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final double scale;

  const BounceAnimation({
    super.key,
    required this.child,
    this.delay = 0,
    this.scale = 1.1,
  });

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(curve);

    // Start animation after delay
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
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

// Alternative: Simple Bounce on Tap
class BounceOnTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;

  const BounceOnTap({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.95,
  });

  @override
  State<BounceOnTap> createState() => _BounceOnTapState();
}

class _BounceOnTapState extends State<BounceOnTap> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 150),
        child: widget.child,
      ),
    );
  }
}