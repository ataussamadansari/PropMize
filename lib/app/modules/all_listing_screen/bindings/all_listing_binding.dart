import 'package:get/get.dart';

import '../../product_details_screen/controllers/product_details_controller.dart';
import '../controllers/all_listing_controller.dart';

class AllListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllListingController>(() => AllListingController());
  }
}
