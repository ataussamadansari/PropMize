import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/common_modules/auth_screen/controllers/auth_controller.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/services/storage/storage_services.dart';
import '../../../../routes/app_routes.dart';
import '../../../common_modules/auth_screen/views/auth_bottom_sheet.dart';

class DashboardController extends GetxController
{
    final AuthController authController = AuthController();

    // ===== Keys =====
    final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    // ===== Computed Getters =====
    RxString get currentUserId => StorageServices.to.userId;

    @override
    void onInit()
    {
        super.onInit();
        _initializeAfterBuild();
    }

    void _initializeAfterBuild()
    {
        Future.delayed(Duration.zero, () async
            {
                await _loadUserProfile();
            }
        );
    }

    /// Load user profile (if token available) and then load chat history.
    Future<void> _loadUserProfile() async
    {
        try
        {
            final token = StorageServices.to.getToken();
            if (token != null && token.isNotEmpty)
            {
                // call your auth controller to fetch profile (await optional)
                await authController.me();

            }
        }
        catch (e)
        {
            // show a friendly error and keep the controller stable
            AppHelpers.showSnackBar(title: "Error", message: e.toString(), isError: true);
        }
        finally
        {

        }
    }

    void showBottomSheet()
    {
        Get.bottomSheet(
            AuthBottomSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent
        );
    }

    void goToProductDetails(String id) => Get.toNamed('/product/$id');
    void goToAllListing() => Get.toNamed(Routes.allListing);
    void goToNotification() => Get.toNamed(Routes.notification);
    void goToProfile() => Get.toNamed(Routes.profile);
    void goToHelpSupport() => Get.toNamed(Routes.helpAndSupport);
    void gotoHome() => Get.offAllNamed(Routes.home);
}
