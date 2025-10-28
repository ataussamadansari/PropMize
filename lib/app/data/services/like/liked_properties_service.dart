import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/services/storage/storage_services.dart';
import '../../../data/repositories/properties/properties_repository.dart';
import '../../../data/models/properties/data.dart';
import 'like_services.dart';

class LikedPropertiesService extends GetxService
{
    final PropertiesRepository _propertiesRepository = PropertiesRepository();


    //=========================================================
    // STATE VARIABLES
    //=========================================================
    final RxList<Data> likedProperties = <Data>[].obs;
    final RxBool isLoading = false.obs;
    final RxBool hasMore = true.obs;
    final RxInt currentPage = 1.obs;
    final RxString errorMessage = ''.obs;
    final RxBool hasError = false.obs;

    final RxInt limit = 10.obs;

    //=========================================================
    // COMPUTED GETTERS
    //=========================================================
    bool get isUserAuthenticated => StorageServices.to.userId.isNotEmpty;

    //=========================================================
    // DATA MANAGEMENT
    //=========================================================

    /// Load liked properties from API
    Future<void> loadLikedProperties({bool reset = true}) async
    {
        if (!isUserAuthenticated)
        {
            _clearData();
            reset;
        }

        try
        {
            if (reset)
            {
                isLoading.value = true;
                currentPage.value = 1;
            }

            final response = await _propertiesRepository.getLikedProperties(
                page: currentPage.value,
                limit: limit.value
            );

            if (response.success && response.data != null)
            {
                final newProperties = response.data!.data ?? [];


                if (reset)
                {
                    likedProperties.assignAll(newProperties);
                }
                else
                {
                    likedProperties.addAll(newProperties);
                }

                // ✅ Sync with LikeService
                final likeService = Get.find<LikeService>();
                for (final property in newProperties) {
                  likeService.likedStatus[property.id!] = true;
                }

                hasMore.value = newProperties.length == limit.value; // Pagination check
            }
        }
        catch(e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            debugPrint('❌ Failed to load liked properties: $e');
        }
        finally
        {
            isLoading.value = false;
        }
    }

    /// Add property to liked list(when user liked a property)
    void addLikedProperty(Data property)
    {
        if (!likedProperties.any((p) => p.id == property.id))
        {
            likedProperties.insert(0, property);
            debugPrint('✅ Property added to liked list: ${property.title}');
        }
    }

    /// Remove property from liked list(when user unliked a property)
    void removeLikedProperty(String propertyId)
    {
        likedProperties.removeWhere((p) => p.id == propertyId);
        debugPrint('✅ Property removed from liked list: $propertyId');
    }

    /// Check if property is liked list
    bool containsProperty(String propertyId)
    {
        return likedProperties.any((p) => p.id == propertyId);
    }

    /// Clear all liked properties (e.g., on logout)
    void _clearData()
    {
        likedProperties.clear();
        isLoading.value = false;
        hasMore.value = true;
        currentPage.value = 1;
    }

    /// Refresh liked properties
    Future<void> refreshLikedProperties() async
    {
        await loadLikedProperties(reset: true);
    }

    /// Load more liked properties for pagination
    Future<void> loadMoreLikedProperties() async
    {
        if (isLoading.value || !hasMore.value || !isUserAuthenticated) return;

        try
        {
            currentPage.value++;
            await loadLikedProperties(reset: false);
        }
        catch (e)
        {
            currentPage.value--;
            debugPrint('❌ Failed to load more liked properties: $e');
        }
    }
}

