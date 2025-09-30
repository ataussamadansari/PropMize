import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/debouncer.dart';
import 'package:prop_mize/app/data/models/properties/properties_model.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/repositories/properties/properties_repository.dart';
import '../../../data/services/storage_services.dart';
import '../views/widgets/filter_bottom_sheet.dart';

class AllListingController extends GetxController
{
    final PropertiesRepository _propertiesRepo = PropertiesRepository();

    // Search
    final TextEditingController searchController = TextEditingController();
    final Debouncer debouncer = Debouncer(milliseconds: 800);

    // Filters
    final RxList<String> selectedPropertyTypes = <String>[].obs;
    final RxList<String> selectedBedrooms = <String>[].obs;
    final RxList<String> selectedBathrooms = <String>[].obs;
    final RxBool showFeaturedOnly = false.obs;
    final RxBool showPremiumOnly = false.obs;

    // Controller me
    var minPrice = 0.0.obs;
    var maxPrice = 10000000.0.obs;

    // Properties
    final RxList<Data> properties = <Data>[].obs;
    final RxBool isLoading = false.obs;
    final RxBool isLoadMore = false.obs;
    final RxBool hasMore = true.obs;
    final RxInt currentPage = 1.obs;
    final RxString errorMessage = ''.obs;
    final RxBool hasError = false.obs;

    final RxString searchText = ''.obs;  // add this

    // current user id
    final currentUserId = StorageServices.to.read("userId");


    @override
    void onInit() 
    {
        super.onInit();
        loadProperties();
    }

    // ---------------- LOAD PROPERTIES ----------------
    Future<void> loadProperties({bool reset = true}) async
    {
        try
        {
            if (reset) 
            {
                isLoading.value = true;
                currentPage.value = 1;
                properties.clear();
                hasMore.value = true;
            }

            hasError.value = false;
            errorMessage.value = '';

            final Map<String, dynamic> filters = {};

            // Apply filters
            if (selectedPropertyTypes.isNotEmpty) filters['propertyType'] = selectedPropertyTypes;
            if (minPrice.value.isGreaterThan(0)) filters['minPrice'] = minPrice.value;
            if (maxPrice.value.isLowerThan(10000000)) filters['maxPrice'] = maxPrice.value;
            if (selectedBedrooms.isNotEmpty) filters['bedrooms'] = selectedBedrooms;
            if (selectedBathrooms.isNotEmpty) filters['bathrooms'] = selectedBathrooms;
            if (showFeaturedOnly.value) filters['featured'] = true;
            if (showPremiumOnly.value) filters['premium'] = true;

            // If search query exists, use search endpoint
            final response = searchText.isNotEmpty
                ? await _propertiesRepo.searchProperties(
                    query: searchText.value,
                    page: currentPage.value,
                    limit: 10,
                    filters: filters.isNotEmpty ? filters : null
                )
                : await _propertiesRepo.getProperties(
                    page: currentPage.value,
                    limit: 10,
                    filters: filters.isNotEmpty ? filters : null
                );

            if (response.success && response.data != null) 
            {
                final newProperties = response.data!.data ?? [];

                if (reset) 
                {
                    properties.value = newProperties;
                }
                else 
                {
                    properties.addAll(newProperties);
                }

                hasMore.value = newProperties.length == 10; // Pagination check
            }
            else 
            {
                hasError.value = true;
                errorMessage.value = response.message;
            }
        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
        }
        finally
        {
            isLoading.value = false;
            isLoadMore.value = false;
        }
    }

    // ---------------- SEARCH ----------------
    void searchProperties(String query) 
    {
        searchText.value = query;
        currentPage.value = 1;
        properties.clear();
        hasMore.value = true;
        loadProperties(reset: true);
    }

    void clearSearch() 
    {
        searchController.clear();
        searchText.value = "";
        removeFocus();
        loadProperties(reset: true);
    }

    void removeFocus() 
    {
        FocusScopeNode currentFocus = FocusScope.of(Get.context!);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) 
        {
            currentFocus.focusedChild!.unfocus();
        }
    }

    // ---------------- LOAD MORE ----------------
    Future<void> loadMoreProperties() async
    {
        if (isLoadMore.value || !hasMore.value) return;

        try
        {
            isLoadMore.value = true;
            currentPage.value++;
            await loadProperties(reset: false);
        }
        catch (e)
        {
            currentPage.value--;
            hasError.value = true;
            errorMessage.value = e.toString();
        }
        finally
        {
            isLoadMore.value = false;
        }
    }

    // ---------------- FILTERS ----------------
    void applyFilters() 
    {
        loadProperties(reset: true);
    }

    void clearFilters() 
    {
        removeFocus();
        selectedPropertyTypes.clear();
        maxPrice.value = 10000000.0;
        minPrice.value = 0.0;
        selectedBedrooms.clear();
        selectedBathrooms.clear();
        showFeaturedOnly.value = false;
        showPremiumOnly.value = false;
        loadProperties(reset: true);
    }

    void showFilterBottomSheet() 
    {
        Get.bottomSheet(
            const FilterBottomSheet(),
            isScrollControlled: true
        );
    }

    // ---------- Like - Dislike ----------
    // Add this method to check like status for a specific property
    bool isPropertyLiked(Data property) {
        return property.likedBy?.any((like) => like.user == currentUserId) ?? false;
    }

    // Update the toggleLike method
    void toggleLike(String productId, int index) async
    {
        if (properties.isEmpty) return;
        if (currentUserId == null)
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to like",
                isError: true,
                actionLabel: "Login"
            );
            return;
        }

        // Find the property and get current like status
        final propertyIndex = properties.indexWhere((p) => p.id == productId);
        if (propertyIndex == -1) return;

        final property = properties[propertyIndex];
        final previousStatus = isPropertyLiked(property);

        try
        {
            final response = await _propertiesRepo.like(productId);
            if (!response.success)
            {
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: true
                );
            }
            else
            {
                // Update the local likedBy array to reflect the change
                if (previousStatus) {
                    // Remove like
                    property.likedBy?.removeWhere((like) => like.user == currentUserId);
                } else {
                    // Add like
                    property.likedBy ??= [];
                    property.likedBy!.add(LikedBy(user: currentUserId));
                }

                // Force UI update by reassigning the list
                properties[propertyIndex] = property;
                properties.refresh();

                AppHelpers.showSnackBar(
                    title: "Property",
                    message: !previousStatus ? "Liked successfully" : "Disliked successfully",
                    isError: !previousStatus ? false : true
                );
            }
        }
        catch (e)
        {
            AppHelpers.showSnackBar(
                title: "error",
                message: e.toString(),
                isError: true
            );
        }
    }

    // Add this method to update like status
    void updateLikeStatus({required String propertyId, required bool isLiked}) {
        final propertyIndex = properties.indexWhere((p) => p.id == propertyId);
        if (propertyIndex != -1) {
            final property = properties[propertyIndex];

            if (isLiked) {
                // Add like
                property.likedBy ??= [];
                if (!property.likedBy!.any((like) => like.user == currentUserId)) {
                    property.likedBy!.add(LikedBy(user: currentUserId));
                }
            } else {
                // Remove like
                property.likedBy?.removeWhere((like) => like.user == currentUserId);
            }

            // Update the property in the list
            properties[propertyIndex] = property;
            properties.refresh(); // This triggers UI update
        }
    }


    // ------------ Navigation -----------------
    void navigateToPropertyDetails(String propertyId) 
    {
        Get.toNamed('/product/$propertyId');
    }

    @override
    void onClose() 
    {
        searchController.dispose();
        _propertiesRepo.cancelRequests();
        super.onClose();
    }
}
