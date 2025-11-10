import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/communication_helper.dart';
import 'widgets/step_basic_details.dart';
import 'widgets/step_location_features.dart';
import 'widgets/step_media_pricing.dart';
import 'widgets/step_review_submit.dart';

import '../controllers/sell_rent_property_controller.dart';

class SellRentPropertyView extends GetView<SellRentPropertyController>
{
    const SellRentPropertyView({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: Column(
                children: [
                    _buildAppBar(),
                    _buildStepper(),
                    Expanded(
                        child: PageView(
                            controller: controller.pageController,
                            physics: const NeverScrollableScrollPhysics(), // Disable swipe
                            children: const[
                                StepBasicDetails(),
                                StepLocationFeatures(), // Create this widget
                                StepMediaPricing(),   // Create this widget
                                StepReviewSubmit() // Create this widget
                            ]
                        )
                    )
                ]
            ),
            bottomNavigationBar: _buildNavigationButtons()
        );
    }

    Widget _buildAppBar()
    {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text('Add Property', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ElevatedButton.icon(
                        onPressed: ()
                        {
                          CommunicationHelper.openWhatsApp(
                              '8580677390',
                              // message: "Hello Admin 👋, I’m a property owner and I’d like to add my property on your app. Please guide me through the process."
                          );
                        },
                        icon: Icon(FontAwesomeIcons.whatsapp),
                        label: Text('List via What\'sApp'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green
                        )
                    )
                ]
            )
        );
    }

    Widget _buildStepper()
    {
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
                        _stepperIcon(Icons.reviews, 'Review', 3)
                    ]
                )
            )
        );
    }

    Widget _stepperIcon(IconData icon, String label, int index)
    {
        final bool isActive = controller.currentStep.value >= index;
        final bool isCurrent = controller.currentStep.value == index;
        // final color = isActive ? Get.theme.primaryColor : Colors.grey;
        final color = isActive ? isCurrent ? Get.theme.primaryColor : Colors.green : Colors.grey;

        return GestureDetector(
            onTap: () => controller.onStepTapped(index),
            child: Column(
                children: [
                    CircleAvatar(
                        radius: isCurrent ? 20 : 16,
                        backgroundColor: color,
                        child: Icon(icon, color: Colors.white, size: isCurrent ? 20 : 18)
                    ),
                    const SizedBox(height: 4),
                    Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.normal))
                ]
            )
        );
    }

    Widget _stepperLine()
    {
        return Expanded(
            child: Container(
                height: 2,
                color: Colors.grey.shade300
            )
        );
    }

    // Update navigation buttons to show "Update" instead of "Submit"
    Widget _buildNavigationButtons()
    {
        return Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        if (controller.currentStep.value > 0)
                        OutlinedButton.icon(
                            onPressed: controller.previousStep,
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.transparent
                            ),
                            icon: const Icon(Icons.skip_previous),
                            label: const Text('Back')
                        )
                        else
                        const SizedBox(),

                        Obx(() => controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : ElevatedButton.icon(
                                    onPressed: controller.nextStep,
                                    iconAlignment: IconAlignment.end,
                                    icon: Icon(controller.currentStep.value == 3
                                            ? Icons.check
                                            : Icons.skip_next
                                    ),
                                    label: Text(
                                        controller.currentStep.value == 3
                                            ? 'Submit' : 'Next'
                                    )
                                ))
                    ]
                )
            ));
    }
}
