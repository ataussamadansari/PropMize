import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/properties/lists/features.dart';

class FeatureItem extends StatelessWidget {
  final Features features;
  const FeatureItem({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    final featureMap = {
      "Facing": features.facing,
      "Flooring": features.flooringType,
      "Water Supply": features.waterSupply,
      "Power Backup": features.powerBackup != null
          ? (features.powerBackup! ? "Yes" : "No")
          : null,
      "Servant Room": features.servantRoom != null
          ? (features.servantRoom! ? "Yes" : "No")
          : null,
      "Pooja Room": features.poojaRoom != null
          ? (features.poojaRoom! ? "Yes" : "No")
          : null,
      "Study Room": features.studyRoom != null
          ? (features.studyRoom! ? "Yes" : "No")
          : null,
      "Store Room": features.storeRoom != null
          ? (features.storeRoom! ? "Yes" : "No")
          : null,
      "Garden": features.garden != null
          ? (features.garden! ? "Yes" : "No")
          : null,
      "Swimming Pool": features.swimmingPool != null
          ? (features.swimmingPool! ? "Yes" : "No")
          : null,
      "Gym": features.gym != null
          ? (features.gym! ? "Yes" : "No")
          : null,
      "Lift": features.lift != null
          ? (features.lift! ? "Yes" : "No")
          : null,
      "Security": features.security != null
          ? (features.security! ? "Yes" : "No")
          : null,
    };


    // Filter only non-null and non-empty entries
    final filtered = featureMap.entries
        .where((e) => e.value != null && e.value.toString().trim().isNotEmpty)
        .toList();

    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.theme.colorScheme.surfaceContainerHighest,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.cardColor,
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: filtered.map((e) {
          return SizedBox(
            width: (MediaQuery.of(context).size.width / 2) - 35,
            // 2 columns bana dega (padding & spacing adjust kar lena)
            child: FeatureSubItem(
              title: e.key,
              value: e.value.toString(),
            ),
          );
        }).toList(),
      ),
    );



    /*return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.theme.colorScheme.surfaceContainerHighest,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.cardColor,
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: filtered
            .map((e) => FeatureSubItem(title: e.key, value: e.value.toString()))
            .toList(),
      ),
    );*/
  }
}

class FeatureSubItem extends StatelessWidget {
  final String? title;
  final String? value;
  const FeatureSubItem({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.theme.colorScheme.surfaceContainerHighest,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: context.theme.cardColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title ?? "",
              style: context.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value ?? "",
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
