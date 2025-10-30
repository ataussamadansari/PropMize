import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';

class GuideHeader extends StatelessWidget {
  const GuideHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 85, bottom: 16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.home_work_rounded,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          Text(
            'Smart Property Investment',
            style: Get.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Apni dream property ko safely aur confidently kharidein',
            style: Get.textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}