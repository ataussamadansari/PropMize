import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Image Carousel Shimmer
        Container(
          height: 400,
          color: Colors.grey.shade300,
          child: Shimmer(
            child: Container(
              width: double.infinity,
              height: 400,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Title Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Shimmer(
            child: Container(
              width: double.infinity,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Address Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Shimmer(
            child: Container(
              width: 200,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Status Cards Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: _buildStatusShimmer(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatusShimmer(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatusShimmer(),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Pricing Card Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildPricingShimmer(),
        ),

        const SizedBox(height: 24),

        // Property Overview Shimmer
        _buildSectionShimmer(
          title: "Property Overview",
          child: _buildPropertyOverviewShimmer(),
        ),

        const SizedBox(height: 24),

        // Description Shimmer
        _buildSectionShimmer(
          title: "Description",
          child: _buildDescriptionShimmer(),
        ),

        const SizedBox(height: 24),

        // Amenities Shimmer
        _buildSectionShimmer(
          title: "Amenities",
          child: _buildAmenitiesShimmer(),
        ),

        const SizedBox(height: 24),

        // Features Shimmer
        _buildSectionShimmer(
          title: "Features",
          child: _buildFeaturesShimmer(),
        ),

        const SizedBox(height: 24),

        // Contact Details Shimmer
        _buildSectionShimmer(
          title: "Contact Details",
          child: _buildContactShimmer(),
        ),

        const SizedBox(height: 24),

        // Location Details Shimmer
        _buildSectionShimmer(
          title: "Location Details",
          child: _buildLocationShimmer(),
        ),

        const SizedBox(height: 80), // Space for bottom bar
      ],
    );
  }

  Widget _buildSectionShimmer({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Shimmer(
            child: Container(
              width: 120,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildStatusShimmer() {
    return Shimmer(
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildPricingShimmer() {
    return Shimmer(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildPropertyOverviewShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Shimmer(
            child: Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer(
            child: Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer(
            child: Container(
              width: 200,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer(
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer(
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildContactShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer(
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}