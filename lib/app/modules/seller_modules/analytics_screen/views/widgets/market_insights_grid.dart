import 'package:flutter/material.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/data/models/properties/analytics/analytics_model.dart';

class MarketInsightsGrid extends StatelessWidget
{
  final List<MarketInsights> insights;
  const MarketInsightsGrid({super.key, required this.insights});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Market Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                // Increase the aspect ratio to give more vertical space
                double childAspectRatio = crossAxisCount == 1 ? 1.8 : 1.2;

                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: insights.length,
                    itemBuilder: (context, index) {
                      return _buildInsightCard(insights[index], context);
                    }
                );
              }
          )
        ]
    );
  }

  Widget _buildInsightCard(MarketInsights insight, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                insight.title ?? 'N/A',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 8),
              Text(
                insight.value ?? '',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary
                ),
              ),
              const SizedBox(height: 10),
              // Use Flexible instead of Expanded and limit maxLines
              Flexible(
                child: Text(
                  insight.insight ?? '',
                  style: const TextStyle(fontSize: 12),
                  maxLines: 3, // Limit to 3 lines
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Wrap(
                    spacing: 4,
                    children: [
                      Text(
                          "Recommendation:",
                          style: TextStyle(fontSize: 11, color: AppColors.primary)
                      ),
                      Text(
                          insight.recommendation ?? '',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)
                      )
                    ]
                ),
              )
            ]
        ),
      ),
    );
  }
}
