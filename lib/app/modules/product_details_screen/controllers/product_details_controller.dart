import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/utils/communication_helper.dart';
import 'package:prop_mize/app/data/models/properties/property_by_id_model.dart';
import 'package:prop_mize/app/data/services/storage_services.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/repositories/properties/properties_repository.dart';

class ProductDetailsController extends GetxController
{
    final PropertiesRepository _propertiesRepository = PropertiesRepository();

    // Reactive Variables
    final productDetails = Rxn<PropertyByIdModel>();
    final RxBool isLoading = false.obs;
    final RxBool hasError = false.obs;
    final RxString errorMessage = "".obs;

    var showFloatingContact = true.obs;
    final contactKey = GlobalKey();

    final currentUserId = StorageServices.to.read("userId");

    final RxBool isLiked = false.obs;

    late String productId;

    PropertyByIdModel? get details => productDetails.value;

    @override
    void onInit()
    {
        super.onInit();
        productId = Get.parameters['id'] ?? '';
        if (productId.isNotEmpty)
        {
            getProductDetails(productId);
        }
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

                // Like status initialize
                final liked = response.data!.data?.likedBy?.any((like) => like.user == currentUserId) ?? false;
                isLiked.value = liked;
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
    void toggleLike() async
    {
        if (details?.data == null) return;
        if (currentUserId == null)
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to like",
                isError: true,
                actionLabel: "Login",
                onActionTap: () => Get.toNamed(Routes.auth)
            );
            return;
        }
        final previous = isLiked.value;
        isLiked.value = !previous;

        try
        {
            final response = await _propertiesRepository.like(productId);
            if (!response.success)
            {
                isLiked.value = previous;
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: isLiked.value ? true : false
                );
            }
            else
            {
                AppHelpers.showSnackBar(
                    title: "Property",
                    message: isLiked.value ? "Liked successfully" : "Disliked successfully",
                    // message: response.data!.message!,
                    isError: isLiked.value ? false : true
                );
            }
        }
        catch (e)
        {
            isLiked.value = previous;
            AppHelpers.showSnackBar(
                title: "error", 
                message: e.toString(), isError: true
            );
        }
    }

    // Contact
    void contact(String? phone) 
    {
        if (currentUserId == null) 
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to contact",
                isError: true,
                actionLabel: "Login",
                onActionTap: () => Get.toNamed(Routes.auth)
            );
            return;
        }
        CommunicationHelper.makeCall(phone);
    }

    // WhatsApp
    void whatsapp(String? phone) 
    {
        if (currentUserId == null) 
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "Please login to contact",
                isError: true,
                actionLabel: "Login",
                onActionTap: () => Get.toNamed(Routes.auth)
            );
            return;
        }
        CommunicationHelper.openWhatsApp(phone);
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
