import 'package:flutter/material.dart';


class InfiniteBounceAnimation extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final Duration duration;

  const InfiniteBounceAnimation({
    super.key,
    required this.child,
    this.minScale = 0.9,
    this.maxScale = 1.1,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<InfiniteBounceAnimation> createState() => _InfiniteBounceAnimationState();
}

class _InfiniteBounceAnimationState extends State<InfiniteBounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true); // Infinite animation

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.repeat(reverse: true);
    });
  }


  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

}