import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/global_widgets/shimmer/analytics_shimmer_view.dart';
import 'widgets/market_insights_grid.dart';
import 'widgets/overall_stats_grid.dart';
import 'widgets/performance_by_day.dart';
import 'widgets/property_performance_list.dart';
import '../controllers/analytics_controller.dart';
import 'widgets/views_inquiries_chart.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.fetchAnalytics(),
      child: Scaffold(
        body: Obx(() {
          if (controller.isLoading.value) {
            return const AnalyticsShimmerView();
          }
          if (controller.hasError.value) {
            return Center(child: Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)));
          }
          if (controller.analyticsData.value == null) {
            return const Center(child: Text("No analytics data available."));
          }

          final data = controller.analyticsData.value!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterChips(),
                const SizedBox(height: 24),
                if (data.overallStats != null) OverallStatsGrid(stats: data.overallStats!),
                const SizedBox(height: 24),
                if (data.periodData != null) ViewsInquiriesChart(periodData: data.periodData!),
                const SizedBox(height: 24),
                if (data.periodData != null) PerformanceByDay(periodData: data.periodData!),
                const SizedBox(height: 24),
                if (data.propertyAnalytics != null) PropertyPerformanceList(properties: data.propertyAnalytics!),
                const SizedBox(height: 24),
                if (data.marketInsights != null) MarketInsightsGrid(insights: data.marketInsights!),
                const SizedBox(height: 24),
                _buildUpgradeCard(context),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Builds the filter chips for selecting the time period.
  Widget _buildFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.periodOptions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final period = controller.periodOptions[index];
          return Obx(() {
            final isSelected = controller.selectedPeriod.value == period;
            return ChoiceChip(
              label: Text(period),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  controller.changePeriod(period);
                }
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Get.theme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: isSelected ? Get.theme.primaryColor : Colors.grey.shade300,
                ),
              ),
              showCheckmark: false,
            );
          });
        },
      ),
    );
  }


  Widget _buildUpgradeCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Want More Detailed Analytics?", style: context.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text("Upgrade to Premium for advanced insights, competitor analysis, and personalized recommendations.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bolt_fill),
              label: const Text("Upgrade to Premium"),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              icon: const Icon(CupertinoIcons.person_2),
              label: const Text("Schedule Consultation"),
            )
          ],
        ),
      ),
    );
  }
}

