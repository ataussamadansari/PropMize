import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionItem extends StatelessWidget {
  final String? description;
  const DescriptionItem({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          border: BoxBorder.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
          borderRadius: BorderRadius.circular(8.0),
          color: context.theme.cardColor,
      ),
      child: Text(description ?? "No description available", style: context.textTheme.bodyLarge)
    );
  }
}
