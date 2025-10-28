import 'package:get/get.dart';
import 'package:prop_mize/app/modules/buyer_modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';
import 'package:prop_mize/app/modules/buyer_modules/contacted_screen/controllers/contacted_controller.dart';
import 'package:prop_mize/app/modules/buyer_modules/recent_viewed_screen/controllers/recent_viewed_controller.dart';
import 'package:prop_mize/app/modules/buyer_modules/saved_properties_screen/controllers/saved_properties_controller.dart';
import 'package:prop_mize/app/modules/common_modules/all_listing_screen/controllers/all_listing_controller.dart';

import '../controllers/buyer_main_controller.dart';

class BuyerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerMainController>(() => BuyerMainController());

    Get.lazyPut<ContactedController>(() => ContactedController());
    Get.lazyPut<SavedPropertiesController>(() => SavedPropertiesController());
    Get.lazyPut<AssistantChatController>(() => AssistantChatController());
    Get.lazyPut<RecentViewedController>(() => RecentViewedController());
    Get.lazyPut<AllListingController>(() => AllListingController());
  }
}
