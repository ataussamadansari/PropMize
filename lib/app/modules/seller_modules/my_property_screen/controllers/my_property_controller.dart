import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/status_message_model.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/models/properties/data.dart';
import '../../../../data/repositories/properties/properties_repository.dart';
import '../../sell_rent_property_screen/controllers/sell_rent_property_controller.dart';

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

        if (isRefresh)
        {
          properties.value = newProperties;
        }
        else
        {
          properties.addAll(newProperties);
        }

        // properties.addAll(newProperties);
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

  Future<void> deleteProperty(String propertyId) async {
    try {
      final response = await _propertiesRepo.deleteProperty(propertyId);

      if (response.success) {
        final status = StatusMessageModel();
        status.message = response.message;
        status.success = response.success;

        AppHelpers.showSnackBar(
            title: 'Property deleted successfully.',
            message: status.message!,
          isError: false
        );
      } else {
        AppHelpers.showSnackBar(
            title: "Property Deletion Failed",
            message: "Property could not be deleted. ${response.message}",
          isError: true
        );
      }
    } catch (e) {
      AppHelpers.showSnackBar(
          title: "Property Deletion Error",
          message: "An error occurred while deleting the property: $e",
        isError: true
      );
    }
  }


  //--------------------------------------------------------------------------
  /// Navigation Methods
  //--------------------------------------------------------------------------

  void gotoEditProperty(Data property) {
    // ✅ CORRECTED: Use Get.put to ensure controller is available
    final sellRentController = Get.put(SellRentPropertyController());

    // First load the full property data, then navigate
    _loadPropertyForEditing(property, sellRentController);
  }

  Future<void> _loadPropertyForEditing(Data property, SellRentPropertyController controller) async {
    controller.loadPropertyForEditing(property);

    // Navigate to edit screen
    Get.toNamed('/sell-rent-property');
  }
}
