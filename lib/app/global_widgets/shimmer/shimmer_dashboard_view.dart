import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDashboardView extends StatelessWidget {
  const ShimmerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header Shimmer
          _buildShimmerContainer(width: 100, height: 22),
          const SizedBox(height: 8),
          _buildShimmerContainer(width: 200, height: 26),
          const SizedBox(height: 8),
          _buildShimmerContainer(width: 250, height: 30),
          const SizedBox(height: 24),

          // Stats Grid Shimmer
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5,
            children: List.generate(4, (_) => _buildShimmerCard()),
          ),
          const SizedBox(height: 24),

          // Recent Inquiries Shimmer
          _buildShimmerContainer(width: double.infinity, height: 300),

          const SizedBox(height: 24),
          _buildShimmerContainer(width: double.infinity, height: 300),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}


/*

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDashboardView extends StatelessWidget
{
    const ShimmerDashboardView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.0,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.withAlpha(100),
                  highlightColor: Colors.grey.withAlpha(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withAlpha(100),
                  highlightColor: Colors.grey.withAlpha(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withAlpha(100),
                  highlightColor: Colors.grey.withAlpha(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),

                Shimmer.fromColors(
                  baseColor: Colors.grey.withAlpha(100),
                  highlightColor: Colors.grey.withAlpha(50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
}
*/
