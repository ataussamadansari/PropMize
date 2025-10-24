// lib/app/core/utils/animation/ola_background.dart
import 'package:flutter/material.dart';

import '../../core/utils/animation/animated_builder_widget.dart';

class OlaBackground extends StatelessWidget {
  final Color primaryColor;
  final List<Widget>? children;
  final bool showWaves;
  final bool showDots;
  final double waveOpacity;
  final double dotOpacity;

  const OlaBackground({
    Key? key,
    required this.primaryColor,
    this.children,
    this.showWaves = true,
    this.showDots = true,
    this.waveOpacity = 0.08,
    this.dotOpacity = 0.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Base gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor.withOpacity(0.05),
                  primaryColor.withOpacity(0.02),
                  Colors.white,
                  primaryColor.withOpacity(0.03),
                ],
              ),
            ),
          ),

          // Animated waves
          if (showWaves) ..._buildWaves(),

          // Floating dots
          if (showDots) ..._buildDots(),

          // Custom children
          ...?children,
        ],
      ),
    );
  }

  List<Widget> _buildWaves() {
    return [
      _buildAnimatedWave(
        size: 200,
        color: primaryColor.withOpacity(waveOpacity),
        top: -50,
        left: -30,
        duration: 15000,
      ),
      _buildAnimatedWave(
        size: 150,
        color: primaryColor.withOpacity(waveOpacity - 0.02),
        top: 100,
        right: -20,
        duration: 12000,
      ),
      _buildAnimatedWave(
        size: 180,
        color: primaryColor.withOpacity(waveOpacity - 0.01),
        bottom: 200,
        left: -40,
        duration: 18000,
      ),
      _buildAnimatedWave(
        size: 120,
        color: primaryColor.withOpacity(waveOpacity - 0.03),
        bottom: 50,
        right: -30,
        duration: 14000,
      ),
    ];
  }

  List<Widget> _buildDots() {
    return [
      _buildFloatingDot(
        size: 8,
        color: primaryColor.withOpacity(dotOpacity),
        top: 150,
        left: 50,
        duration: 8000,
      ),
      _buildFloatingDot(
        size: 6,
        color: primaryColor.withOpacity(dotOpacity - 0.02),
        top: 300,
        right: 80,
        duration: 6000,
      ),
      _buildFloatingDot(
        size: 10,
        color: primaryColor.withOpacity(dotOpacity + 0.02),
        bottom: 150,
        left: 100,
        duration: 10000,
      ),
    ];
  }

  Widget _buildAnimatedWave({
    required double size,
    required Color color,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required int duration,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilderWidget(
        duration: Duration(milliseconds: duration),
        autoPlay: true,
        builder: (context, animation, child) {
          final scale = 1.0 + (0.3 * animation.value);
          final opacity = 0.5 + (0.5 * (1 - animation.value).abs());

          return Transform.scale(
            scale: scale,
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(opacity * 0.3),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingDot({
    required double size,
    required Color color,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required int duration,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilderWidget(
        duration: Duration(milliseconds: duration),
        autoPlay: true,
        builder: (context, animation, child) {
          final offset = 20.0 * (animation.value - 0.5).abs();

          return Transform.translate(
            offset: Offset(0, offset),
            child: Opacity(
              opacity: 0.7 + (0.3 * (1 - animation.value).abs()),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}