import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/common_modules/profile_screen/bindings/profile_binding.dart';
import 'package:prop_mize/app/modules/common_modules/profile_screen/views/profile_view.dart';
import 'package:prop_mize/app/modules/seller_modules/dashboard_screen/controllers/dashboard_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/dashboard_screen/views/dashboard_view.dart';
import 'package:prop_mize/app/modules/seller_modules/leads_screen/bindings/leads_binding.dart';
import 'package:prop_mize/app/modules/seller_modules/leads_screen/views/leads_view.dart';
import 'package:prop_mize/app/modules/seller_modules/my_property_screen/views/my_property_view.dart';
import 'package:prop_mize/app/modules/seller_modules/sell_rent_property_screen/bindings/sell_rent_property_binding.dart';
import 'package:prop_mize/app/modules/seller_modules/sell_rent_property_screen/views/sell_rent_property_view.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

import '../../my_property_screen/bindings/my_property_binding.dart';

class SellerMainController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Rx variable for selected tab
  final RxInt currentTabIndex = 0.obs;

  // Tab screens
  late final List<Widget> screens;

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();


  @override
  void onInit() {
    super.onInit();
    screens = [
      const DashboardView(),
      const LeadsView(),
      const SellRentPropertyView(),
      const MyPropertyView(),
      const ProfileView(),
    ];
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  /// Navigation
  void gotoHelpSupport() => Get.toNamed(Routes.helpAndSupport);
}
