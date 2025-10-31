import 'package:get/get.dart';

import '../../../../data/models/properties/my_property/my_property_model.dart';
import '../../../../data/repositories/properties/properties_repository.dart';

class MyPropertyController extends GetxController {
  final PropertiesRepository _propertiesRepo = PropertiesRepository();

  // Properties
  final RxList<Data> properties = <Data>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  final RxInt limit = 10.obs;


  @override
  void onInit() {
    super.onInit();
    loadMyProperties();
  }

  /// Load my properties with pagination support.
  Future<void> loadMyProperties({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
      hasMore.value = true;
      properties.clear();
    }

    // Prevent multiple simultaneous requests
    if (isLoadMore.value || !hasMore.value) return;

    try {
      if (currentPage.value == 1) {
        isLoading.value = true;
      } else {
        isLoadMore.value = true;
      }
      hasError.value = false;

      final response = await _propertiesRepo.getMyProperties(
        page: currentPage.value,
        limit: limit.value,
      );

      if (response.success && response.data != null) {
        final newProperties = response.data!.data ?? [];
        properties.addAll(newProperties);
        hasMore.value = newProperties.length == limit.value;
        currentPage.value++;
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }
}
