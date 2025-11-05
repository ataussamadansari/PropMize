import 'package:get/get.dart';

class PlansController extends GetxController {
  // Use an enum to represent the billing cycle for clarity
  final Rx<BillingCycle> selectedCycle = BillingCycle.monthly.obs;

  // Track the currently selected/recommended plan
  final Rx<PlanType> selectedPlan = PlanType.premium.obs;

  void selectBillingCycle(BillingCycle cycle) {
    selectedCycle.value = cycle;
  }

  void selectPlan(PlanType plan) {
    selectedPlan.value = plan;
  }
}

// Enums to make the code more readable and less error-prone
enum BillingCycle { monthly, yearly }
enum PlanType { basic, premium, enterprise }
