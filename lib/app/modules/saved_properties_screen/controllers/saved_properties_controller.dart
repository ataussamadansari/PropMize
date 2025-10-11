import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/repositories/properties/properties_repository.dart';

import '../../../data/models/properties/data.dart';
import '../../../data/services/like_services.dart';
import '../../../data/services/storage_services.dart';

class SavedPropertiesController extends GetxController {
  final PropertiesRepository _propertiesRepository = PropertiesRepository();
  final LikeService likeService = Get.find<LikeService>();

  // Properties
  final RxList<Data> properties = <Data>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  // Current user id
  final String? currentUserId = StorageServices.to.read("userId");

  @override
  void onInit() {
    super.onInit();
    loadLikedProperties();

    // Listen for like status changes and remove unliked properties
    ever(likeService.likedStatus, (_) {
      _syncPropertiesWithLikeService();
    });
  }

  void _syncPropertiesWithLikeService() {
    properties.removeWhere((property) => !likeService.isLiked(property.id!));
    properties.refresh();
  }

  Future<void> loadLikedProperties({bool reset = true}) async {
    try {
      if (reset) {
        isLoading.value = true;
        currentPage.value = 1;
        properties.clear();
        hasMore.value = true;
        hasError.value = false;
        errorMessage.value = '';
      } else {
        isLoadMore.value = true;
      }

      final response = await _propertiesRepository.getLikedProperties(
        page: currentPage.value,
        limit: 10,
      );

      if (response.success && response.data != null) {
        // Access the data list from PropertiesModel
        final newProperties = response.data!.data ?? [];

        // Sync with global like service
        _syncWithLikeService(newProperties);

        if (reset) {
          properties.value = newProperties;
        } else {
          properties.addAll(newProperties);
        }

        // Check if there are more pages
        hasMore.value = newProperties.length == 10;

        debugPrint('✅ Properties loaded successfully: ${properties.length}');
      } else {
        _handleError(response.message);
      }
    } catch (e, stackTrace) {
      _handleError('Failed to load properties: ${e.toString()}');
      debugPrint('❌ Error in loadLikedProperties: $e');
      debugPrint('📋 Stack trace: $stackTrace');
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  void _syncWithLikeService(List<Data> newProperties) {
    for (final property in newProperties) {
      likeService.syncWithProperty(property);
    }
  }

  void _handleError(String message) {
    hasError.value = true;
    errorMessage.value = message;
  }

  // ---------------- LOAD MORE ----------------
  Future<void> loadMoreProperties() async {
    if (isLoadMore.value || !hasMore.value || isLoading.value) return;

    try {
      currentPage.value++;
      await loadLikedProperties(reset: false);
    } catch (e) {
      currentPage.value--; // Revert page on error
      _handleError(e.toString());
    }
  }

  // ---------------- REFRESH ----------------
  Future<void> refreshProperties() async {
    await loadLikedProperties(reset: true);
  }

  // ---------------- PROPERTY MANAGEMENT ----------------

  // Remove a property from the list (when unliked from elsewhere)
  void removeProperty(String propertyId) {
    properties.removeWhere((property) => property.id == propertyId);
    properties.refresh();
  }

  // Add a property to the list (when liked from elsewhere)
  void addProperty(Data property) {
    if (!properties.any((p) => p.id == property.id)) {
      properties.insert(0, property); // Add at the beginning
      likeService.syncWithProperty(property);
    }
  }

  // Check if property exists in the list
  bool containsProperty(String propertyId) {
    return properties.any((property) => property.id == propertyId);
  }

  // ---------------- NAVIGATION ----------------
  void navigateToPropertyDetails(String propertyId) {
    Get.toNamed('/product/$propertyId');
  }

  // ---------------- DISPOSE ----------------
  @override
  void onClose() {
    // Cancel any ongoing requests if needed
    super.onClose();
  }
}