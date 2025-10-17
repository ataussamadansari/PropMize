import 'package:get/get.dart';

import '../controllers/contacted_controller.dart';

class ContactedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactedController>(() => ContactedController());
  }
}
