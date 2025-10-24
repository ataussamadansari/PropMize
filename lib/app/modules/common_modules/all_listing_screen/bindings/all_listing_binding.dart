import 'package:get/get.dart';

import '../controllers/all_listing_controller.dart';

class AllListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllListingController>(() => AllListingController());
  }
}
