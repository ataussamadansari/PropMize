import 'package:get/get.dart';

import '../controllers/saved_properties_controller.dart';

class SavedPropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedPropertiesController>(() => SavedPropertiesController());
  }
}
