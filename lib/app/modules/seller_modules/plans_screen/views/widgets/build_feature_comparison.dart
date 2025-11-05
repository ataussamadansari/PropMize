import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/plans_controller.dart';

class BuildFeatureComparison extends GetView<PlansController> {
  const BuildFeatureComparison({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Feature Comparison', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Feature', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Basic', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Premium', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Enterprise', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('Property Listings')),
                DataCell(Text('5')),
                DataCell(Text('50')),
                DataCell(Text('Unlimited')),
              ]),
              DataRow(cells: [
                DataCell(Text('Featured Property')),
                DataCell(Icon(Icons.close, color: Colors.red)),
                DataCell(Icon(Icons.check, color: Colors.green)),
                DataCell(Icon(Icons.check, color: Colors.green)),
              ]),
              DataRow(cells: [
                DataCell(Text('Advanced Analytics')),
                DataCell(Icon(Icons.close, color: Colors.red)),
                DataCell(Icon(Icons.check, color: Colors.green)),
                DataCell(Icon(Icons.check, color: Colors.green)),
              ]),
              DataRow(cells: [
                DataCell(Text('Dedicated Agent')),
                DataCell(Icon(Icons.close, color: Colors.red)),
                DataCell(Icon(Icons.close, color: Colors.red)),
                DataCell(Icon(Icons.check, color: Colors.green)),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
