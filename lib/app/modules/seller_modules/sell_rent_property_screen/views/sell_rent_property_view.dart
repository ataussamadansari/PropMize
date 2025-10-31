import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/step_basic_details.dart';
import 'widgets/step_location_features.dart';
import 'widgets/step_media_pricing.dart';
import 'widgets/step_review_submit.dart';

import '../controllers/sell_rent_property_controller.dart';

class SellRentPropertyView extends GetView<SellRentPropertyController> {
  const SellRentPropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Property'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              children: const [
                StepBasicDetails(),
                StepLocationFeatures(), // Create this widget
                StepMediaPricing(),   // Create this widget
                StepReviewSubmit(),   // Create this widget
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildNavigationButtons(),
    );
  }

  Widget _buildStepper() {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _stepperIcon(Icons.description, 'Basic Details', 0),
            _stepperLine(),
            _stepperIcon(Icons.location_on, 'Location & Features', 1),
            _stepperLine(),
            _stepperIcon(Icons.camera_alt, 'Media & Pricing', 2),
            _stepperLine(),
            _stepperIcon(Icons.reviews, 'Review', 3),
          ],
        ),
      ),
    );
  }

  Widget _stepperIcon(IconData icon, String label, int index) {
    final bool isActive = controller.currentStep.value >= index;
    final bool isCurrent = controller.currentStep.value == index;
    final color = isActive ? Get.theme.primaryColor : Colors.grey;

    return GestureDetector(
      onTap: () => controller.onStepTapped(index),
      child: Column(
        children: [
          CircleAvatar(
            radius: isCurrent ? 20 : 16,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: isCurrent ? 20 : 18),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _stepperLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (controller.currentStep.value > 0)
            OutlinedButton.icon(
              onPressed: controller.previousStep,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              icon: const Icon(Icons.skip_previous),
              label: const Text('Back'),
            )
          else
            const SizedBox(), // Keep space even if button is not visible

          Obx(() => controller.isLoading.value
              ? const CircularProgressIndicator()
              : ElevatedButton.icon(
            onPressed: controller.nextStep,
            iconAlignment: IconAlignment.end,
            icon: Icon(controller.currentStep.value == 3 ? Icons.check : Icons.skip_next),
            label: Text(controller.currentStep.value == 3 ? 'Submit' : 'Next'),
          )),
        ],
      ),
    ));
  }
}
