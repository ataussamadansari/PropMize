import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AnalyticsShimmerView extends StatelessWidget {
  const AnalyticsShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer for Filter Chips
            _FilterChipsShimmer(),
            SizedBox(height: 24),

            // Shimmer for Overall Stats Grid
            _OverallStatsShimmer(),
            SizedBox(height: 24),

            // Shimmer for Views & Inquiries Chart
            _ChartShimmer(),
            SizedBox(height: 24),

            // Shimmer for Property Performance List
            _TableShimmer(),
            SizedBox(height: 24),

            // Shimmer for Market Insights
            _InsightsShimmer(),
          ],
        ),
      ),
    );
  }
}

// Shimmer widget for the filter chips
class _FilterChipsShimmer extends StatelessWidget {
  const _FilterChipsShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5, // Assuming 3 filter options
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            width: 100, // Approximate width of a chip
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
          );
        },
      ),
    );
  }
}


// Shimmer widget for the top stats grid
class _OverallStatsShimmer extends StatelessWidget {
  const _OverallStatsShimmer();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}

// Shimmer widget for the chart section
class _ChartShimmer extends StatelessWidget {
  const _ChartShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Shimmer widget for the data table
class _TableShimmer extends StatelessWidget {
  const _TableShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Shimmer widget for the insights section
class _InsightsShimmer extends StatelessWidget {
  const _InsightsShimmer();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
        double childAspectRatio = crossAxisCount == 1 ? 2 : 1.2;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          },
        );
      },
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AnalyticsShimmerView extends StatelessWidget {
  const AnalyticsShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer for Overall Stats Grid
            _OverallStatsShimmer(),
            SizedBox(height: 24),

            // Shimmer for Views & Inquiries Chart
            _ChartShimmer(),
            SizedBox(height: 24),

            // Shimmer for Property Performance List
            _TableShimmer(),
            SizedBox(height: 24),

            // Shimmer for Market Insights
            _InsightsShimmer(),
          ],
        ),
      ),
    );
  }
}

// Shimmer widget for the top stats grid
class _OverallStatsShimmer extends StatelessWidget {
  const _OverallStatsShimmer();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}

// Shimmer widget for the chart section
class _ChartShimmer extends StatelessWidget {
  const _ChartShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Shimmer widget for the data table
class _TableShimmer extends StatelessWidget {
  const _TableShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Shimmer widget for the insights section
class _InsightsShimmer extends StatelessWidget {
  const _InsightsShimmer();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
        double childAspectRatio = crossAxisCount == 1 ? 2 : 1.2;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          },
        );
      },
    );
  }
}
*/
