import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../../data/services/storage_services.dart';
import '../../buyer_modules/auth_screen/controllers/auth_controller.dart';
import '../../buyer_modules/auth_screen/views/auth_bottom_sheet.dart';

class HomeController extends GetxController
{
    // ===== Dependencies =====
    final AuthController authController = Get.find<AuthController>();

    String? token = "";
    String? role = "";

    // ===== Computed Getters =====
    RxString get currentUserId => StorageServices.to.userId;

    @override
    void onInit() 
    {
        super.onInit();
        token = StorageServices.to.getToken();
        role = StorageServices.to.read('role');
    }

    void showBottomSheet()
    {
        Get.bottomSheet(
            AuthBottomSheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent
        );
    }

    void navigateHomeToAssistantChat() 
    {
        WidgetsBinding.instance.addPostFrameCallback((_)
            {
                Get.offAllNamed(Routes.assistantChat);
            }
        );
    }

    void navigateHomeToDashboard() 
    {
        WidgetsBinding.instance.addPostFrameCallback((_)
            {
                Get.offAllNamed(Routes.dashboard);
            }
        );
    }
}
