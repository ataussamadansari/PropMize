import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/properties/analytics/analytics_model.dart';

class PropertyPerformanceList extends StatelessWidget {
  final List<PropertyAnalytics> properties;
  const PropertyPerformanceList({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Property Performance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text('Property')),
                  DataColumn(label: Text('Views'), numeric: true),
                  DataColumn(label: Text('Inquiries'), numeric: true),
                  DataColumn(label: Text('Favs'), numeric: true),
                  DataColumn(label: Text('Conversion'), numeric: true),
                  DataColumn(label: Text('Status')),
                ],
                rows: properties.map((prop) => _buildDataRow(prop)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(PropertyAnalytics prop) {
    return DataRow(
      cells: [
        DataCell(Text(prop.title ?? 'N/A', overflow: TextOverflow.ellipsis)),
        DataCell(Text(prop.views.toString())),
        DataCell(Text(prop.inquiries.toString())),
        DataCell(Text(prop.favorites.toString())),
        DataCell(Text('${prop.conversionRate?.toStringAsFixed(1) ?? '0.0'}%')),
        DataCell(
          Chip(
            label: Text(prop.status?.capitalizeFirst ?? 'N/A', style: const TextStyle(color: Colors.white, fontSize: 10)),
            backgroundColor: prop.status == 'active' ? Colors.green : Colors.grey,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}
