import 'package:flutter/material.dart';
import 'package:prop_mize/app/data/models/properties/analytics/analytics_model.dart';

class OverallStatsGrid extends StatelessWidget {
  final List<OverallStats> stats;
  const OverallStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return _buildStatCard(stats[index]);
      },
    );
  }

  Widget _buildStatCard(OverallStats stat) {
    final isUp = stat.trend == 'up';
    final trendColor = isUp ? Colors.green : Colors.red;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(stat.label ?? 'N/A', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(stat.value ?? '0', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(isUp ? Icons.arrow_upward : Icons.arrow_downward, color: trendColor, size: 14),
                Text(
                  stat.change ?? '0%',
                  style: TextStyle(color: trendColor, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
