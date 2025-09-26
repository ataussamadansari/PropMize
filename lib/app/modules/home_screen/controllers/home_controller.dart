import 'package:get/get.dart';
import 'package:prop_mize/app/routes/app_routes.dart';

class HomeController extends GetxController {

  void navigateHomeToAssistantChat() {
    Get.offAllNamed(Routes.assistantChat);
  }
}