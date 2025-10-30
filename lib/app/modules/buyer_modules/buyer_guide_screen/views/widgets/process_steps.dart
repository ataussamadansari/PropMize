import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/themes/app_colors.dart';

class ProcessSteps extends StatelessWidget {
  const ProcessSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Property Buying Process',
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        _BuildProcessStep(
          step: 1,
          title: 'Budget Planning',
          description: 'Apna budget fix karein, home loan eligibility check karein',
        ),
        _BuildProcessStep(
          step: 2,
          title: 'Location Research',
          description: 'Area ki facilities, connectivity aur future development dekhein',
        ),
        _BuildProcessStep(
          step: 3,
          title: 'Property Shortlisting',
          description: 'Requirements ke hisaab se properties shortlist karein',
        ),
        _BuildProcessStep(
          step: 4,
          title: 'Site Visit & Inspection',
          description: 'Personal visit karein, construction quality check karein',
        ),
        _BuildProcessStep(
          step: 5,
          title: 'Legal Verification',
          description: 'Property documents lawyer se verify karayein',
        ),
        _BuildProcessStep(
          step: 6,
          title: 'Loan & Payment',
          description: 'Home loan process start karein aur payment plan final karein',
        ),
        _BuildProcessStep(
          step: 7,
          title: 'Registration',
          description: 'Property registration complete karein',
        ),
      ],
    );
  }
}

class _BuildProcessStep extends StatelessWidget {
  final int step;
  final String title;
  final String description;

  const _BuildProcessStep({
    required this.step,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: context.theme.cardColor,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.headlineMedium!.copyWith(color: AppColors.primary)
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: context.textTheme.bodyMedium
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}