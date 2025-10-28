import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/debouncer.dart';
import 'package:prop_mize/app/data/models/properties/contacted_seller/contacted_seller_request.dart';
import 'package:prop_mize/app/data/models/properties/data.dart';
import 'package:prop_mize/app/data/services/contact_seller_service.dart';
import 'package:prop_mize/app/data/services/storage/current_user_id_services.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/repositories/properties/properties_repository.dart';
import '../../../../data/services/like/like_services.dart';
import '../../../../data/services/storage/storage_services.dart';
import '../../auth_screen/views/auth_bottom_sheet.dart';
import '../views/widgets/filter_bottom_sheet.dart';

class AllListingController extends GetxController
{
    final PropertiesRepository _propertiesRepo = PropertiesRepository();

    final LikeService likeService = Get.find<LikeService>();
    final ContactSellerService contactSellerService = Get.find<ContactSellerService>();
    final CurrentUserIdServices currentUserIdServices = Get.find<CurrentUserIdServices>();

    final phone = StorageServices.to.read("phone");

    final RxInt limit = 10.obs;

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

    final RxString searchText = ''.obs;

    // current user id
    final currentUserId = StorageServices.to.read("userId");


    @override
    void onInit() 
    {
        super.onInit();
        loadProperties();

        /// Jab bhi userId change hoga -> list reload ho jaayegi
        ever(currentUserIdServices.userId, (_) {
            loadProperties();
        });
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
                    limit: limit.value,
                    filters: filters.isNotEmpty ? filters : null
                )
                : await _propertiesRepo.getProperties(
                    page: currentPage.value,
                    limit: limit.value,
                    filters: filters.isNotEmpty ? filters : null
                );

            if (response.success && response.data != null) 
            {
                final newProperties = response.data!.data ?? [];

                // sync with global like service
                for (var p in newProperties) {
                    likeService.syncWithProperty(p);
                }

                if (reset) 
                {
                    properties.value = newProperties;
                }
                else 
                {
                    properties.addAll(newProperties);
                }

                hasMore.value = newProperties.length == limit.value; // Pagination check
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

    // ------------- Contact Seller ----------------
    Future<void> contactedSeller(Data property) async {
        try {
            // Check if property ID is valid
            if (property.id == null || property.id!.isEmpty) {
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: "Invalid property ID",
                    isError: true,
                );
                return;
            }

            // Get current user ID
            final userId = currentUserIdServices.userId.value;
            if (userId == null) {
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: "Please login to contact seller",
                    isError: true,
                    actionLabel: 'Login',
                    onActionTap: () => Get.bottomSheet(
                        AuthBottomSheet(),
                        isScrollControlled: true
                    ),
                );
                return;
            }

            // Create request with proper data
            final request = ContactedSellerRequest(
                propertyId: property.id!,
                message: "I am interested in this property: ${property.title}",
                buyerContact: BuyerContact(
                    contactMethod: "any",
                    phone: phone ?? "N/A"
                ),
            );

            // ✅ Service call karein aur response capture karein
            await contactSellerService.contactedSeller(request);
        } catch (e) {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Failed to contact seller: ${e.toString()}",
                isError: true,
            );
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
