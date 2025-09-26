import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/app_colors.dart';

class CustomNotificationListItem extends StatelessWidget
{
  final String title;
  final String subTitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool isEnable;

    const CustomNotificationListItem({
        super.key,
        required this.title,
        required this.subTitle,
        required this.value,
        required this.onChanged,
        required this.isEnable,
    });

    @override
    Widget build(BuildContext context) 
    {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(title, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.greyDark)),
                        Text(subTitle, style: context.textTheme.bodySmall)
                    ]
                ),
              Switch(value: value, onChanged: isEnable ? onChanged : null)
            ]
        );
    }
}
