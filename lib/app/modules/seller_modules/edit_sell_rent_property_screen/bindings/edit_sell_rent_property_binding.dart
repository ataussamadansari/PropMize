import 'package:get/get.dart';

import '../controllers/edit_sell_rent_property_controller.dart';

class EditSellRentPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditSellRentPropertyController>(() => EditSellRentPropertyController());
  }
}
