import 'package:get/get.dart';

import '../controllers/my_property_controller.dart';


class MyPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPropertyController>(() => MyPropertyController());
  }
}
