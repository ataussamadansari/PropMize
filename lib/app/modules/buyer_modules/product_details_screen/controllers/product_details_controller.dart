import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/communication_helper.dart';
import 'package:prop_mize/app/data/models/properties/property_by_id_model.dart';
import 'package:prop_mize/app/data/services/storage_services.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/repositories/properties/properties_repository.dart';
import '../../../../data/services/current_user_id_services.dart';
import '../../../../data/services/like_services.dart';
import '../../auth_screen/views/auth_bottom_sheet.dart';

class ProductDetailsController extends GetxController
{
    final PropertiesRepository _propertiesRepository = PropertiesRepository();

    final LikeService likeService = Get.find<LikeService>();
    final CurrentUserIdServices currentUserIdServices = Get.find<CurrentUserIdServices>();

    // Reactive Variables
    final productDetails = Rxn<PropertyByIdModel>();
    final RxBool isLoading = false.obs;
    final RxBool hasError = false.obs;
    final RxString errorMessage = "".obs;

    var showFloatingContact = true.obs;
    final contactKey = GlobalKey();

    final currentUserId = StorageServices.to.read("userId");

    // final RxBool isLiked = false.obs;

    late String productId;

    PropertyByIdModel? get details => productDetails.value;

    bool get isLiked {
        if (details?.data == null) return false;
        return likeService.isLiked(details!.data!.id!);
    }

    @override
    void onInit()
    {
        super.onInit();
        productId = Get.parameters['id'] ?? '';
        if (productId.isNotEmpty)
        {
            getProductDetails(productId);
        }

        ever(currentUserIdServices.userId, (_){
            getProductDetails(productId);
        });
    }


    void getProductDetails(String id) async
    {
        try
        {
            isLoading.value = true;
            hasError.value = false;
            errorMessage.value = "";

            final response = await _propertiesRepository.getPropertyById(id);

            if (response.success && response.data != null)
            {
                productDetails.value = response.data;
            }
            else
            {
                hasError.value = true;
                errorMessage.value = response.message;
                AppHelpers.showSnackBar(title: "error", message: errorMessage.value, isError: true);
            }
        }
        catch (e)
        {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(title: "error", message: errorMessage.value, isError: true);
        }
        finally
        {
            isLoading.value = false;
        }
    }

    // like-dislike
    void toggleLike() async {
        if (details?.data == null) return;
        await likeService.toggleLike(details!.data!);
    }

    // Contact
    void contact(String? phone) 
    {
        if (currentUserIdServices.userId.value == null)
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to contact",
                isError: true,
                actionLabel: "Login",
                onActionTap: () => showBottomSheet()
            );
            return;
        }
        CommunicationHelper.makeCall(phone);
    }

    // WhatsApp
    void whatsapp(String? phone) 
    {
        if (currentUserIdServices.userId.value == null)
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to contact",
                isError: true,
                actionLabel: "Login",
                onActionTap: () => showBottomSheet()
            );
            return;
        }
        CommunicationHelper.openWhatsApp(phone);
    }

    // Bottom sheet
    void showBottomSheet() {
        Get.bottomSheet(
            AuthBottomSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent
        );
    }

    bool userId() {
        return currentUserId != null;
    }

    String get fullAddress
    {
        final addr = details?.data?.address;
        if (addr == null) return "Address not available";

        return [
            addr.street,
            addr.area,
            addr.city,
            addr.state,
            addr.zipCode,
            addr.country
        ].where((e) => e != null && e.isNotEmpty).join(", ");
    }
}
