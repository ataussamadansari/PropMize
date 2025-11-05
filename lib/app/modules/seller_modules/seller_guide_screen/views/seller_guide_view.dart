import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/guide/seller_guide_controller.dart';
import '../controllers/seller_guide_controller.dart';

class SellerGuideView extends GetView<SellerGuideController> {
  const SellerGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seller's Guide"),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(colorScheme),
              const SizedBox(height: 24),
              _buildSectionTitle("Getting Started", "Begin your journey with these essential first steps."),
              const SizedBox(height: 16),
              ...controller.gettingStartedItems.map((item) => _buildGuideItem(item)),
              const SizedBox(height: 24),
              _buildSectionTitle("Valuable Tips", "Maximize your listing's potential."),
              const SizedBox(height: 16),
              _buildTipsCard(
                icon: Icons.camera_alt_outlined,
                title: "Photography Tips",
                tips: controller.photographyTips,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              _buildTipsCard(
                icon: Icons.price_change_outlined,
                title: "Effective Pricing Tips",
                tips: controller.pricingTips,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle("Frequently Asked Questions", "Quick answers to common questions."),
              const SizedBox(height: 16),
              _buildFaqSection(),
              const SizedBox(height: 24),
              _buildReadyToListCard(colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            Icons.support_agent,
            size: 40,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Seller's Guide",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "Your complete guide on how to list, manage, and sell your properties on PropMize effectively.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }

  Widget _buildGuideItem(GuideItem item) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Get.theme.primaryColor.withValues(alpha: 0.2),
        foregroundColor: Get.theme.primaryColor,
        child: Icon(item.icon, size: 20),
      ),
      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(item.subtitle),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildTipsCard({required IconData icon, required String title, required List<String> tips, required Color color}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
            const SizedBox(height: 12),
            ...tips.map((tip) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• ", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
                  Expanded(child: Text(tip, style: TextStyle(color: Colors.grey[700]))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    return Column(
      children: controller.faqs.map((faq) {
        return ExpansionTile(
          title: Text(
            faq['question']!,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          expandedAlignment: Alignment.centerLeft,
          children: [
            Text(
              faq['answer']!,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildReadyToListCard(ColorScheme colorScheme) {
    return Card(
      color: colorScheme.primary.withValues(alpha: 0.05),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Ready to Start Listing?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Create your first property listing now and reach thousands of potential buyers.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.gotoListProperty();
              },
              child: const Text("Start Listing Now"),
            ),
          ],
        ),
      ),
    );
  }
}
