import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/data/models/properties/analytics/analytics_model.dart';

class ViewsInquiriesChart extends StatelessWidget {
  final List<PeriodData> periodData;
  const ViewsInquiriesChart({super.key, required this.periodData});

  @override
  Widget build(BuildContext context) {
    // Calculate total views and inquiries for the summary text
    final totalViews = periodData.map((d) => d.views ?? 0).reduce((a, b) => a + b);
    final totalInquiries = periodData.map((d) => d.inquiries ?? 0).reduce((a, b) => a + b);

    // Determine the maximum Y-axis value for the chart
    final maxY = (periodData.map((d) => d.views ?? 0).reduce((a, b) => a > b ? a : b) * 1.2).toDouble();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Views & Inquiries", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildSummaryRow("Total Views This Week", totalViews.toString()),
            const SizedBox(height: 4),
            _buildSummaryRow("Total Inquiries This Week", totalInquiries.toString()),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: FlBorderData(show: false),
                  barGroups: _generateBarGroups(),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Colors.grey,
                        strokeWidth: 0.4,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  alignment: BarChartAlignment.spaceAround,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  // Generates the data groups for the bar chart
  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(periodData.length, (index) {
      final dayData = periodData[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          // Bar for Views
          BarChartRodData(
            toY: (dayData.views ?? 0).toDouble(),
            color: AppColors.primary,
            width: 12,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          // Bar for Inquiries
          BarChartRodData(
            toY: (dayData.inquiries ?? 0).toDouble(),
            color: Colors.deepPurpleAccent,
            width: 12,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ],
        showingTooltipIndicators: [],
      );
    });
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // --- Chart Styling ---

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (double value, TitleMeta meta) {
          final index = value.toInt();
          if (index >= 0 && index < periodData.length) {
            return SideTitleWidget(
              space: 4,
              meta: meta,
              child: Text(periodData[index].day ?? '', style: const TextStyle(fontSize: 12)),
            );
          }
          return const SizedBox();
        },
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: true, reservedSize: 28),
    ),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );

  BarTouchData get barTouchData => BarTouchData(
    enabled: true,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (_) => Colors.blueGrey,
      tooltipPadding: const EdgeInsets.all(8),
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        String label = rodIndex == 0 ? "Views" : "Inquiries";
        return BarTooltipItem(
          '$label\n',
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: rod.toY.round().toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    ),
  );

  // Widget for the chart legend
  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.deepPurpleAccent, "Inquiries"),
        const SizedBox(width: 16),
        _legendItem(AppColors.primary, "Views"),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
