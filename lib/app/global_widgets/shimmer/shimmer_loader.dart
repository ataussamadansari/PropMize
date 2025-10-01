import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(milliseconds: 500),
      color: Colors.grey.shade300,
      colorOpacity: 0.3,
      enabled: true,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    height: 16,
                    width: 200,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),

                  // Location placeholder
                  Container(
                    height: 14,
                    width: 150,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),

                  // Features Row
                  Row(
                    children: List.generate(
                      3,
                          (index) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 14,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Footer Row
                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 14,
                        width: 50,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
