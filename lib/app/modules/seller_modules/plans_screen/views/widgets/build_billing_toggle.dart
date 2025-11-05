import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/seller_modules/plans_screen/controllers/plans_controller.dart';

class BuildBillingToggle extends GetView<PlansController> {
  final String text;
  final BillingCycle cycle;
  const BuildBillingToggle({super.key, required this.text, required this.cycle});

  @override
  Widget build(BuildContext context) {
    bool isSelected = controller.selectedCycle.value == cycle;
    return GestureDetector(
      onTap: () => controller.selectBillingCycle(cycle),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            )
          ]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Get.theme.primaryColor : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
