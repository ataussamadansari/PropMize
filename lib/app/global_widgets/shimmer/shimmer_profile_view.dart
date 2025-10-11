import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerProfileView extends StatelessWidget {
  const ShimmerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              duration: Duration(seconds: 2),
              child: Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 4),
            Shimmer(
              duration: Duration(seconds: 2),
              child: Container(
                width: 200,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Main Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Edit Button Shimmer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // Main Content Area Shimmer
              Expanded(
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        // Profile Header Shimmer
                        _buildProfileHeaderShimmer(),

                        // Profile Details Shimmer
                        _buildProfileDetailsShimmer(),

                        // Preferences Shimmer
                        _buildPreferencesShimmer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Side Tabs Shimmer
          Positioned(
            left: 0,
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Toggle Button Shimmer
                Shimmer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Tabs Menu Shimmer
                ...List.generate(3, (index) => _buildTabItemShimmer(index)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeaderShimmer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Avatar Shimmer
          Shimmer(
            duration: Duration(seconds: 2),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 16),
          // Name and Email Shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    width: 150,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    width: 200,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Shimmer(
                  duration: Duration(seconds: 2),
                  child: Container(
                    width: 100,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetailsShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Section Title
          Shimmer(
            duration: Duration(seconds: 2),
            child: Container(
              width: 120,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Details Grid
          Row(
            children: [
              Expanded(
                child: _buildDetailItemShimmer("Phone"),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDetailItemShimmer("Role"),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildDetailItemShimmer("Status"),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildDetailItemShimmer("Member Since"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItemShimmer(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          duration: Duration(seconds: 2),
          child: Container(
            width: 60,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        SizedBox(height: 4),
        Shimmer(
          duration: Duration(seconds: 2),
          child: Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesShimmer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Shimmer(
            duration: Duration(seconds: 2),
            child: Container(
              width: 100,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Preference Items
          ...List.generate(4, (index) => _buildPreferenceItemShimmer()),
        ],
      ),
    );
  }

  Widget _buildPreferenceItemShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Shimmer(
            duration: Duration(seconds: 2),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Shimmer(
              duration: Duration(seconds: 2),
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItemShimmer(int index) {
    return AnimatedSlide(
      duration: Duration(milliseconds: 300 + (index * 200)),
      offset: Offset(-1.5, 0),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300 + (index * 200)),
        opacity: 0,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Shimmer(
                duration: Duration(seconds: 2),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Shimmer(
                duration: Duration(seconds: 2),
                child: Container(
                  width: 80,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}