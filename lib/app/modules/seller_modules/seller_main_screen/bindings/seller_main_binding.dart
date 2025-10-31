import 'package:get/get.dart';
import 'package:prop_mize/app/modules/common_modules/all_listing_screen/controllers/all_listing_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/analytics_screen/controllers/analytics_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/leads_screen/controllers/leads_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/my_property_screen/controllers/my_property_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/sell_rent_property_screen/controllers/sell_rent_property_controller.dart';

import '../../dashboard_screen/controllers/dashboard_controller.dart';
import '../controllers/seller_main_controller.dart';

class SellerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerMainController>(() => SellerMainController());

    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<LeadsController>(() => LeadsController());
    Get.lazyPut<SellRentPropertyController>(() => SellRentPropertyController());
    Get.lazyPut<MyPropertyController>(() => MyPropertyController());
    Get.lazyPut<AnalyticsController>(() => AnalyticsController());
    Get.lazyPut<AllListingController>(() => AllListingController());
  }
}
