import 'package:get/get.dart';
import 'package:prop_mize/app/modules/common_modules/profile_screen/controllers/profile_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/leads_screen/controllers/leads_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/my_property_screen/controllers/my_property_controller.dart';
import 'package:prop_mize/app/modules/seller_modules/sell_rent_property_screen/controllers/sell_rent_property_controller.dart';

import '../../../common_modules/profile_screen/bindings/profile_binding.dart';
import '../../dashboard_screen/controllers/dashboard_controller.dart';
import '../../leads_screen/bindings/leads_binding.dart';
import '../../my_property_screen/bindings/my_property_binding.dart';
import '../../sell_rent_property_screen/bindings/sell_rent_property_binding.dart';
import '../controllers/seller_main_controller.dart';

class SellerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerMainController>(() => SellerMainController());


    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<LeadsController>(() => LeadsController());
    Get.lazyPut<SellRentPropertyController>(() => SellRentPropertyController());
    Get.lazyPut<MyPropertyController>(() => MyPropertyController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
