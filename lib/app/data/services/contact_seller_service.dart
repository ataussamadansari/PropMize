import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/helpers.dart';
import '../../modules/common_modules/auth_screen/views/auth_bottom_sheet.dart';
import '../models/api_response_model.dart';
import '../models/properties/contacted_seller/contacted_seller_model.dart';
import '../models/properties/contacted_seller/contacted_seller_request.dart';
import '../repositories/properties/properties_repository.dart';
import 'storage/current_user_id_services.dart';

class ContactSellerService extends GetxService {
  final PropertiesRepository _repo = PropertiesRepository();
  final CurrentUserIdServices _userIdService = Get.find<CurrentUserIdServices>();

  Future<ApiResponse<ContactedSellerModel>> contactedSeller(ContactedSellerRequest request) async {
    // Check if user is logged in
    if (_userIdService.userId.value == null) {
      AppHelpers.showSnackBar(
        title: "Error",
        message: "Please login to contact seller",
        isError: true,
        actionLabel: 'Login',
        onActionTap: () => Get.bottomSheet(
          AuthBottomSheet(),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        ),
      );
      return ApiResponse.error("User not logged in");
    }

    try {
      final response = await _repo.contactedSeller(request);

      if (response.success) {
        AppHelpers.showSnackBar(
          title: "Success",
          message: "Seller contacted successfully!",
          isError: false,
        );
      } else {
        AppHelpers.showSnackBar(
          title: "Error",
          message: response.message,
          isError: true,
        );
      }

      return response;
    } catch (e) {
      AppHelpers.showSnackBar(
        title: "Error",
        message: "Failed to contact seller: ${e.toString()}",
        isError: true,
      );
      return ApiResponse.error(e.toString());
    }
  }
}