import 'package:get/get.dart';

import '../controllers/sell_rent_property_controller.dart';

class SellRentPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellRentPropertyController>(() => SellRentPropertyController());
  }
}
