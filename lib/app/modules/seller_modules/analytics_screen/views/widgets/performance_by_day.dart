import 'package:flutter/material.dart';
import 'package:prop_mize/app/data/models/properties/analytics/analytics_model.dart';

class PerformanceByDay extends StatelessWidget {
  final List<PeriodData> periodData;
  const PerformanceByDay({super.key, required this.periodData});

  @override
  Widget build(BuildContext context) {
    int maxViews = 0;
    for (var data in periodData) {
      if (data.views! > maxViews) maxViews = data.views!;
    }
    // Avoid division by zero if maxViews is 0
    if (maxViews == 0) maxViews = 1;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Performance by Day", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            ...periodData.map((data) => _buildPerformanceRow(data, maxViews)),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceRow(PeriodData data, int maxViews) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 35, child: Text(data.day ?? '', style: TextStyle(fontSize: 13, color: Colors.grey[700]))),
          Expanded(
            child: LinearProgressIndicator(
              value: (data.views ?? 0) / maxViews,
              backgroundColor: Colors.grey[200],
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 50, child: Text("${data.views ?? 0} views", textAlign: TextAlign.end, style: TextStyle(fontSize: 13, color: Colors.grey[700]))),
        ],
      ),
    );
  }
}
