import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/seller_dashboard/seller_dashboard_model.dart';
import 'package:prop_mize/app/data/repositories/seller_dashboard/dashboard_repository.dart';
import 'package:prop_mize/app/modules/common_modules/auth_screen/controllers/auth_controller.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/services/storage/storage_services.dart';
import '../../../../routes/app_routes.dart';
import '../../../common_modules/auth_screen/views/auth_bottom_sheet.dart';

class DashboardController extends GetxController
{
    // ===== Dependencies =====
    final AuthController authController = Get.find<AuthController>();
    final DashboardRepository dashboardRepository = DashboardRepository();

    // ===== Keys =====
    final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    // ===== Computed Getters =====
    RxString get currentUserId => StorageServices.to.userId;

    // ===== Reactive Variables =====
    final sellerDashboardModel = Rxn<SellerDashboardModel>();
    final RxBool hasError = false.obs;
    final RxString errorMessage = "".obs;
    final RxBool isLoading = false.obs;

    @override
    void onInit()
    {
        super.onInit();
        _setupListeners();
        _initializeAfterBuild();
    }

    _setupListeners(){
    }

    void _initializeAfterBuild()
    {
        loadDashboardData();
        Future.delayed(Duration.zero, () async
            {
                await _loadUserProfile();
            }
        );
    }

    /// Load dashboard data
    Future<void> loadDashboardData() async {
        try {
            isLoading.value = true;
            hasError.value = false;
            errorMessage.value = "";

            final response = await dashboardRepository.fetchDashboardData();
            if(response.success && response.data != null) {
                sellerDashboardModel.value = response.data;
            } else {
                hasError.value = true;
                errorMessage.value = "Failed to load dashboard data.";
            }
        } catch (e) {
            hasError.value = true;
            errorMessage.value = e.toString();
            AppHelpers.showSnackBar(title: "Error", message: e.toString(), isError: true);
        } finally {
            isLoading.value = false;
        }
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

    void showAuthBottomSheet()
    {
        Get.bottomSheet(
            AuthBottomSheet(),
            isScrollControlled: true
        );
    }

    void goToProductDetails(String id) => Get.toNamed('/product/$id');
    void goToNotification() => Get.toNamed(Routes.notification);
    void goToProfile() => Get.toNamed(Routes.profile);
    void goToHelpSupport() => Get.toNamed(Routes.helpAndSupport);
    void gotoHome() => Get.offAllNamed(Routes.home);
}
