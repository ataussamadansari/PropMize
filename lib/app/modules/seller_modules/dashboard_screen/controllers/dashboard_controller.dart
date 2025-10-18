import 'package:get/get.dart';

import '../../../../data/services/storage/storage_services.dart';
import '../../../../routes/app_routes.dart';
import '../../../buyer_modules/auth_screen/controllers/auth_controller.dart';

class DashboardController extends GetxController {
  // ===== Dependencies =====
  final AuthController authController = Get.find<AuthController>();

  // ===== Computed Getters =====
  RxString get currentUserId => StorageServices.to.userId;


  // Navigation
  void goToHome() => Get.offAllNamed(Routes.home);
}
