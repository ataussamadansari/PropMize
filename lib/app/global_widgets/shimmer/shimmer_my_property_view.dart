import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMyPropertyView extends StatelessWidget {
  const ShimmerMyPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: 5, // Display 5 shimmer cards
        itemBuilder: (context, index) {
          return _buildShimmerCard(context);
        },
      ),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Container(
            height: 180,
            width: double.infinity,
            color: Colors.white,
          ),
          // Details Placeholder
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Placeholder
                Container(
                  height: 18.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(height: 8),
                // Description Placeholder
                Container(
                  height: 14.0,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(height: 12),
                // Info Icons Placeholder
                Row(
                  children: [
                    _buildShimmerInfoIcon(context, width: 100),
                    const SizedBox(width: 16),
                    _buildShimmerInfoIcon(context, width: 80),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildShimmerInfoIcon(context, width: 120),
                    const SizedBox(width: 16),
                    _buildShimmerInfoIcon(context, width: 100),
                  ],
                ),
                const Divider(height: 24),
                // Price and Date Placeholder
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 18.0,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    Container(
                      height: 12.0,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action Buttons Placeholder
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShimmerInfoIcon(BuildContext context, {required double width}) {
    return Container(
      height: 16,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
    );
  }
}
