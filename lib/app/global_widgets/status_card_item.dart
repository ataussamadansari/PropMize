import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusCardItem extends StatelessWidget {
  final String? title;
  const StatusCardItem({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final isActive = title?.toLowerCase() == "active";
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green // ✅ Active ka special color
            : theme.cardColor, // ✅ Light/Dark dono me auto
        border: Border.all(
          color: colorScheme.outlineVariant, // ✅ Border auto light/dark
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        isActive ? title!.toUpperCase() : title?.capitalizeFirst ?? '',
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: isActive
              ? Colors.white
              : colorScheme.onSurface, // ✅ Readable text color
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusCardItem extends StatelessWidget {
  final String? title;
  const StatusCardItem({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: title?.toLowerCase() == "active" ? Colors.green : Colors.white,
        border: BoxBorder.all(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(title?.toLowerCase() == "active" ? title!.toUpperCase() : title?.capitalizeFirst ?? '', style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),),
    );
  }
}
*/
