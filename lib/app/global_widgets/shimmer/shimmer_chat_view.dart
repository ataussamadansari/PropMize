import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChatView extends StatelessWidget {
  const ShimmerChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withAlpha(100),
      highlightColor: Colors.grey.withAlpha(50),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        itemCount: 5,
        itemBuilder: (context, index) {
          bool isAssistant = index % 2 == 0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: isAssistant ? MainAxisAlignment.start : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isAssistant) ...[
                  // Assistant avatar shimmer
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                // ✅ FIX: ConstrainedBox use karo width limit ke liye
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75, // ✅ Max width 75%
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: isAssistant ? Radius.zero : const Radius.circular(12),
                        topRight: isAssistant ? const Radius.circular(12) : Radius.zero,
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Message text lines
                        Container(
                          width: double.infinity,
                          height: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 6),
                        if (index % 3 == 0)
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 12,
                            color: Colors.white,
                          ),

                        // Property cards shimmer (for assistant messages)
                        if (isAssistant && index % 4 == 0) ...[
                          const SizedBox(height: 12),
                          _buildPropertyShimmer(context), // ✅ Context pass karo
                        ],
                      ],
                    ),
                  ),
                ),

                if (!isAssistant) ...[
                  const SizedBox(width: 8),
                  // User avatar shimmer
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPropertyShimmer(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Full width of parent
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property image
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Container(
            width: double.infinity,
            height: 16,
            color: Colors.white,
          ),
          const SizedBox(height: 6),

          // Address
          Container(
            width: 150,
            height: 12,
            color: Colors.white,
          ),
          const SizedBox(height: 6),

          // Price
          Container(
            width: 100,
            height: 14,
            color: Colors.white,
          ),
          const SizedBox(height: 8),

          // ✅ FIX: Wrap use karo features row ke liye
          Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              Container(
                width: 60,
                height: 12,
                color: Colors.white,
              ),
              Container(
                width: 60,
                height: 12,
                color: Colors.white,
              ),
              Container(
                width: 80,
                height: 12,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}