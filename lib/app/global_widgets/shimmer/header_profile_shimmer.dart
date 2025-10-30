import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HeaderProfileShimmer extends StatelessWidget {
  const HeaderProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withAlpha(100),
      highlightColor: Colors.grey.withAlpha(50),
      enabled: true,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            spacing: 4,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle
                ),
              ),

              Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12.0)
                ),
              ),

              Container(
                width: 120,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12.0)
                ),
              ),
              Container(
                width: 85,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4.0)
                ),
              ),
            ],
          ),
        ),
    );
  }
}
