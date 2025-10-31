import 'package:get/get.dart';

import '../../../../data/repositories/properties/properties_repository.dart';
import '../../../../data/models/properties/analytics/analytics_model.dart';

class AnalyticsController extends GetxController {
  final PropertiesRepository _propertiesRepo = Get.put(PropertiesRepository());

  // --- State Management ---
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  // --- Data ---
  final Rxn<Data> analyticsData = Rxn<Data>();
  final RxString selectedPeriod = 'Last 30 days'.obs;
  final RxList<String> periodOptions = <String>['Last 7 days', 'Last 30 days', 'Last 90 days', 'Last year'].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnalytics();
  }

  /// Fetches analytics data from the repository.
  Future<void> fetchAnalytics() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      String periodCode = _getPeriodCode(selectedPeriod.value);
      final response = await _propertiesRepo.analyticsProperty(period: periodCode);

      if (response.success && response.data != null) {
        analyticsData.value = response.data!.data;
      } else {
        hasError.value = true;
        errorMessage.value = response.message ?? "Failed to load analytics data.";
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  /// Changes the time period and refetches the data.
  void changePeriod(String? newPeriod) {
    if (newPeriod != null && selectedPeriod.value != newPeriod) {
      selectedPeriod.value = newPeriod;
      fetchAnalytics();
    }
  }

  /// Helper to convert dropdown text to API period code.
  String _getPeriodCode(String period) {
    switch (period) {
      case 'Last 7 days':
        return '7d';
      case 'Last 90 days':
        return '90d';
      case 'Last Year':
        return '1y';
      case 'Last 30 days':
      default:
        return '30d';
    }
  }
}
