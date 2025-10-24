import 'package:get/get.dart';

import '../controllers/recent_viewed_controller.dart';

class RecentViewedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentViewedController>(() => RecentViewedController());
  }
}
