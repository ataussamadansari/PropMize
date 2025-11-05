import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/plans_screen/controllers/plans_controller.dart';

class BuildPlanCard extends GetView<PlansController> {
  final PlanType planType;
  final IconData icon;
  final String title;
  final String price;
  final String? period;
  final List<String> features;
  final bool isRecommended;
  const BuildPlanCard({
    super.key,
    required this.planType,
    required this.icon,
    required this.title,
    required this.price,
    this.period,
    required this.features,
    this.isRecommended = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedPlan.value == planType;
      return GestureDetector(
        onTap: () => controller.selectPlan(planType),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: isSelected ? Colors.white : Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Get.theme.primaryColor :
              context.theme.primaryColor.withValues(alpha: 0.2),
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Get.theme.primaryColor.withValues(alpha: 0.15),
                spreadRadius: 3,
                blurRadius: 8,
              )
            ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isRecommended)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Most Popular',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Get.theme.primaryColor.withValues(alpha: 0.1),
                    child: Icon(icon, color: Get.theme.primaryColor),
                  ),
                  const SizedBox(width: 12),
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(price, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  if (period != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(period!, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              ...features.map((feature) => _buildFeatureItem(feature)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: isSelected
                    ? ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Upgrade to this Plan', style: TextStyle(fontWeight: FontWeight.bold)),
                )
                    : OutlinedButton(
                  onPressed: () => controller.selectPlan(planType),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Choose Plan'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: Colors.grey[700]))),
        ],
      ),
    );
  }
}
