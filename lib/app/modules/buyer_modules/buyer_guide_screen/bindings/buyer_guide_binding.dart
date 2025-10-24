import 'package:get/get.dart';

import '../controllers/buyer_guide_controller.dart';

class BuyerGuideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerGuideController>(() => BuyerGuideController());
  }
}
