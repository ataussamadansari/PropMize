import 'package:get/get.dart';
import '../../../../data/models/properties/data.dart';

import '../../../../data/services/like/like_services.dart';
import '../../../../data/services/like/liked_properties_service.dart';
import '../../../../data/services/storage/storage_services.dart';
import '../../../common_modules/auth_screen/views/auth_bottom_sheet.dart';

class SavedPropertiesController extends GetxController
{
    // =========================================================
    // DEPENDENCIES
    // =========================================================
    final LikeService likeService = Get.find<LikeService>();
    final LikedPropertiesService likedPropertiesService = Get.find<LikedPropertiesService>(); // 🔥 NEW

    // =========================================================
    // STATE VARIABLES
    // =========================================================
    // final RxList<Data> properties = <Data>[].obs;
    RxList<Data> get properties => likedPropertiesService.likedProperties;
    RxBool get isLoading => likedPropertiesService.isLoading;
    RxBool get hasMore => likedPropertiesService.hasMore;
    RxInt get currentPage => likedPropertiesService.currentPage;
    RxString get errorMessage => likedPropertiesService.errorMessage;
    RxBool get hasError => likedPropertiesService.hasError;


    // =========================================================
    // COMPUTED GETTERS
    // =========================================================
    RxString get currentUserId => StorageServices.to.userId;
    bool get isUserAuthenticated => currentUserId.isNotEmpty;

    // =========================================================
    // LIFECYCLE METHODS
    // =========================================================
    @override
    void onInit() 
    {
        super.onInit();
        // Load liked properties on init
        likedPropertiesService.loadLikedProperties();

        // 🔄 Listen to authentication changes
        ever(StorageServices.to.userId, (String userId)
            {
                if (userId.isNotEmpty) 
                {
                    loadLikedProperties();
                }
                else
                {
                    _clearDataOnLogout();
                }
            }
        );
    }

    // =========================================================
    // DATA FETCHING (Delegate to service)
    // =========================================================
    Future<void> loadLikedProperties() async {
        await likedPropertiesService.loadLikedProperties(reset: true);
    }

    Future<void> loadMoreProperties() async {
        await likedPropertiesService.loadMoreLikedProperties();
    }

    Future<void> refreshProperties() async {
        await likedPropertiesService.refreshLikedProperties();
    }


    // =========================================================
    // AUTHENTICATION HANDLING
    // =========================================================
    void _clearDataOnLogout() 
    {
        properties.clear();
        isLoading.value = false;
        hasMore.value = true;
        currentPage.value = 1;
        hasError.value = false;
        errorMessage.value = '';
    }


    // =========================================================
    // PROPERTY MANAGEMENT
    // =========================================================
    void removeProperty(String propertyId) {
        likedPropertiesService.removeLikedProperty(propertyId);
    }

    bool containsProperty(String propertyId) {
        return likedPropertiesService.containsProperty(propertyId);
    }

    // =========================================================
    // NAVIGATION
    // =========================================================
    void navigateToPropertyDetails(String propertyId) 
    {
        Get.toNamed('/product/$propertyId');
    }

    void showAuthBottomSheet() 
    {
        Get.bottomSheet(
            const AuthBottomSheet(),
            isScrollControlled: true
        );
    }
}
