import 'package:flutter/material.dart';

class BounceAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scale;
  final bool autoPlay;
  final int repeatCount;
  final bool infinite;

  const BounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500), // Slower default
    this.scale = 1.2,
    this.autoPlay = true,
    this.repeatCount = 1,
    this.infinite = false,
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
      duration: widget.duration,
      vsync: this,
    );

    // Create a more natural bounce curve
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: widget.scale)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40, // 40% of time for scaling up
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.scale, end: 1.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 60, // 60% of time for bouncing back
      ),
    ]).animate(_controller);

    if (widget.autoPlay) {
      if (widget.infinite) {
        _controller.repeat(reverse: false);
      } else if (widget.repeatCount > 1) {
        _controller.repeat(count: widget.repeatCount);
      } else {
        _controller.forward();
      }
    }
  }

  void play() => _controller.forward();
  void bounce() => _controller.repeat();
  void stop() => _controller.stop();
  void reset() => _controller.reset();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}