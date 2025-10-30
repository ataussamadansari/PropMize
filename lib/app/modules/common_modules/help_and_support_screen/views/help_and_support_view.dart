import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';
import '../controllers/help_and_support_controller.dart';
import 'widgets/contact_method_card.dart';
import 'widgets/faq_item.dart';
import 'widgets/support_header.dart';

class HelpAndSupportView extends GetView<HelpAndSupportController> {
  const HelpAndSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Section
            const SupportHeader(),

            const SizedBox(height: 32),

            // Contact Methods
            _buildContactSection(),

            const SizedBox(height: 32),

            // FAQ Section
            _buildFAQSection(),

            const SizedBox(height: 24),

            // Additional Help Section
            _buildAdditionalHelp(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Methods',
          style: Get.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Get in touch with our support team through multiple channels',
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 20),

        // Contact Methods Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: controller.contactMethods.length,
          itemBuilder: (context, index) {
            return ContactMethodCard(
              contact: controller.contactMethods[index],
              onTap: () => controller.contactSupport(
                controller.contactMethods[index]['action'],
                controller.contactMethods[index]['value'],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequently Asked Questions',
          style: Get.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Quick answers to common questions',
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 20),

        // FAQ List
        ...controller.faqs.map((faq) => FAQItem(faq: faq)).toList(),
      ],
    );
  }

  Widget _buildAdditionalHelp() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.help_outline_rounded,
            size: 48,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Need More Help?',
            style: Get.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Our customer support team is available 24/7 to assist you with any queries related to property buying, selling, or verification.',
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              controller.contactSupport('whatsapp', '+91 9876543210');
            },
            icon: const Icon(Icons.chat),
            label: const Text('Chat with Support'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}