import 'package:get/get.dart';

import '../controllers/seller_guide_controller.dart';

class SellerGuideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerGuideController>(() => SellerGuideController());
  }
}
