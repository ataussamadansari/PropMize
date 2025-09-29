import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/debouncer.dart';
import 'package:prop_mize/app/data/models/properties/properties_model.dart';

import '../../../data/repositories/properties/properties_repository.dart';
import '../views/widgets/filter_bottom_sheet.dart';

class AllListingController extends GetxController {
  final PropertiesRepository _propertiesRepo = PropertiesRepository();

  // Search
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer = Debouncer(milliseconds: 500);

  // Filters
  final RxList<String> selectedPropertyTypes = <String>[].obs;
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final RxList<String> selectedBedrooms = <String>[].obs;
  final RxBool showFeaturedOnly = false.obs;
  final RxBool showPremiumOnly = false.obs;

  // Properties
  final RxList<Data> properties = <Data>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProperties();
  }

  Future<void> loadProperties({bool reset = true}) async {
    try {
      if (reset) {
        isLoading.value = true;
        currentPage.value = 1;
        properties.clear();
        hasMore.value = true;
      }

      hasError.value = false;
      errorMessage.value = '';

      final Map<String, dynamic> filters = {};

      // Apply filters
      if (selectedPropertyTypes.isNotEmpty) {
        filters['propertyType'] = selectedPropertyTypes;
      }
      if (minPriceController.text.isNotEmpty) {
        filters['minPrice'] = int.tryParse(minPriceController.text);
      }
      if (maxPriceController.text.isNotEmpty) {
        filters['maxPrice'] = int.tryParse(maxPriceController.text);
      }
      if (selectedBedrooms.isNotEmpty) {
        filters['bedrooms'] = selectedBedrooms;
      }
      if (showFeaturedOnly.value) {
        filters['featured'] = true;
      }
      if (showPremiumOnly.value) {
        filters['premium'] = true;
      }

      final response = await _propertiesRepo.getProperties(
        page: currentPage.value,
        limit: 10,
        filters: filters.isNotEmpty ? filters : null,
      );

      if (response.success && response.data != null) {
        final newProperties = response.data!.data ?? [];

        if (reset) {
          properties.value = newProperties;
        } else {
          properties.addAll(newProperties);
        }

        hasMore.value = newProperties.length == 10; // If we got less than limit, no more data
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  Future<void> searchProperties(String query) async {
    try {
      isLoading.value = true;
      currentPage.value = 1;
      properties.clear();
      hasMore.value = true;

      final response = await _propertiesRepo.searchProperties(
        query: query,
        page: currentPage.value,
        limit: 10,
      );

      if (response.success && response.data != null) {
        properties.value = response.data!.data ?? [];
        hasMore.value = properties.length == 10;
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProperties() async {
    if (isLoadMore.value || !hasMore.value) return;

    try {
      isLoadMore.value = true;
      currentPage.value++;

      await loadProperties(reset: false);
    } catch (e) {
      currentPage.value--;
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoadMore.value = false;
    }
  }

  void clearSearch() {
    searchController.clear();
    loadProperties();
  }

  void showFilterBottomSheet() {
    Get.bottomSheet(
      const FilterBottomSheet(),
      isScrollControlled: true,
    );
  }

  void applyFilters() {
    loadProperties(reset: true);
  }

  void clearFilters() {
    selectedPropertyTypes.clear();
    minPriceController.clear();
    maxPriceController.clear();
    selectedBedrooms.clear();
    showFeaturedOnly.value = false;
    showPremiumOnly.value = false;
    loadProperties(reset: true);
  }

  void navigateToPropertyDetails(String propertyId) {
      Get.toNamed('/product/$propertyId');
  }

  @override
  void onClose() {
    searchController.dispose();
    _propertiesRepo.cancelRequests();
    super.onClose();
  }
}