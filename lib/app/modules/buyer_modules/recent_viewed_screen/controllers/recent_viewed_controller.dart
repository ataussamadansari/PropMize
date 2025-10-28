import 'package:get/get.dart';
import 'package:prop_mize/app/data/services/storage/storage_services.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/models/properties/contacted_seller/contacted_seller_request.dart';
import '../../../../data/repositories/properties/properties_repository.dart';
import '../../../../data/services/contact_seller_service.dart';
import '../../../../data/services/like/like_services.dart';
import '../../../../data/services/storage/current_user_id_services.dart';
import '../../../common_modules/auth_screen/views/auth_bottom_sheet.dart';
import '../../../../data/models/properties/data.dart';

class RecentViewedController extends GetxController
{

    final PropertiesRepository _propertiesRepo = PropertiesRepository();
    final LikeService likeService = Get.find<LikeService>();
    final ContactSellerService contactSellerService = Get.find<ContactSellerService>();
    final CurrentUserIdServices currentUserIdServices = Get.find<CurrentUserIdServices>();

    // Properties
    final RxList<Data> properties = <Data>[].obs;
    final RxBool isLoading = false.obs;
    final RxString errorMessage = ''.obs;
    final RxBool hasError = false.obs;

    final phone = StorageServices.to.read("phone");

    // current user id
    final currentUserId = StorageServices.to.read("userId");
    bool get isAuthenticated => currentUserIdServices.userId.value != null;

    @override
    void onInit()
    {
        super.onInit();
        loadRecentViedProperties();

        /// Jab bhi userId change hoga -> list reload ho jaayegi
        ever(currentUserIdServices.userId, (_)
            {
                loadRecentViedProperties();
            }
        );
    }

    // ---------------- LOAD PROPERTIES ----------------
    Future<void> loadRecentViedProperties({bool reset = true}) async
    {
        try
        {
            if (reset)
            {
                isLoading.value = true;
                properties.clear();
            }

            hasError.value = false;
            errorMessage.value = '';

            // If search query exists, use search endpoint
            final response = await _propertiesRepo.getRecentViewedProperties();

            if (response.success && response.data != null)
            {
                final newProperties = response.data!.data ?? [];

                // sync with global like service
                for (var p in newProperties)
                {
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
        }
    }

    // ------------- Contact Seller ----------------
    Future<void> contactedSeller(Data property) async
    {
        try
        {
            // Check if property ID is valid
            if (property.id == null || property.id!.isEmpty) 
            {
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: "Invalid property ID",
                    isError: true
                );
                return;
            }

            // Get current user ID
            final userId = currentUserIdServices.userId.value;
            if (userId == null) 
            {
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: "Please login to contact seller",
                    isError: true,
                    actionLabel: 'Login',
                    onActionTap: () => Get.bottomSheet(
                        AuthBottomSheet(),
                        isScrollControlled: true
                    )
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
                )
            );

            // ✅ Service call karein aur response capture karein
            await contactSellerService.contactedSeller(request);
        }
        catch (e)
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Failed to contact seller: ${e.toString()}",
                isError: true
            );
        }
    }

    void showAuthBottomSheet() 
    {
        Get.bottomSheet(
            isScrollControlled: true,
            AuthBottomSheet()
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
        _propertiesRepo.cancelRequests();
        super.onClose();
    }

}
