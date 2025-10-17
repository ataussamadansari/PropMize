import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/contacted_screen/controllers/contacted_controller.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContactedView extends GetView<ContactedController> {
  const ShimmerContactedView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6, // 6 shimmer items
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[900]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Image and Basic Info Shimmer
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Image Shimmer
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Property Details Shimmer
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 20,
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 100,
                              height: 16,
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 150,
                              height: 14,
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Seller Info Shimmer
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 16,
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 80,
                              height: 14,
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Lead Status and Info Shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Message Shimmer
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 200,
                    height: 14,
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 12),
                  // Date Shimmer
                  Container(
                    width: 100,
                    height: 12,
                    color: Colors.grey.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}