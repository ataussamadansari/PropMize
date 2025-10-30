import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';

class FAQItem extends StatefulWidget {
  final Map<String, dynamic> faq;

  const FAQItem({super.key, required this.faq});

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        leading: Icon(
          Icons.help_outline_rounded,
          color: AppColors.primary,
        ),
        title: Text(
          widget.faq['question'],
          style: Get.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
          color: AppColors.primary,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Text(
              widget.faq['answer'],
              style: Get.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}