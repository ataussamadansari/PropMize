import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLeadDetailsView extends StatelessWidget {
  const ShimmerLeadDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Chips Row ---
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(4, (_) => _chipsWidget(width)),
            ),
            const SizedBox(height: 16),

            // --- Image Placeholder ---
            Container(
              width: width,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 16),

            // --- Details Section ---
            Container(
              width: width,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 20),

            // --- Buttons Row ---
            Row(
              children: [
                _btnWidget(),
                const SizedBox(width: 12),
                _btnWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chipsWidget(double width) {
    final random = Random();
    final randomWidth = width * (0.3 + random.nextDouble() * 0.3);
    // chip width between 25%–55% of total width

    return Container(
      width: randomWidth,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _btnWidget() {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
