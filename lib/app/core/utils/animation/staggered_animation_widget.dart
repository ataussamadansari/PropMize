import 'package:flutter/material.dart';

class StaggeredAnimation {
  StaggeredAnimation(this.controller)
      : opacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ),
  ),
        scale = Tween<double>(
          begin: 0.5,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
          ),
        ),
        slide = Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
          ),
        );

  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<Offset> slide;
}

class StaggeredAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const StaggeredAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<StaggeredAnimationWidget> createState() =>
      _StaggeredAnimationWidgetState();
}

class _StaggeredAnimationWidgetState extends State<StaggeredAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late StaggeredAnimation _staggeredAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _staggeredAnimation = StaggeredAnimation(_controller);
    _controller.forward();
  }

  void play() => _controller.forward();
  void reverse() => _controller.reverse();
  void reset() => _controller.reset();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _staggeredAnimation.opacity.value,
          child: Transform.scale(
            scale: _staggeredAnimation.scale.value,
            child: SlideTransition(
              position: _staggeredAnimation.slide,
              child: widget.child,
            ),
          ),
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