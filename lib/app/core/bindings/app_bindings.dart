import 'package:get/get.dart';

import '../../data/services/auth/google_auth_service.dart';
import '../../data/services/contact_seller_service.dart';
import '../../data/services/like_services.dart';
import '../../data/services/storage/current_user_id_services.dart';
import '../../data/services/storage/storage_services.dart';
import '../../modules/buyer_modules/auth_screen/controllers/auth_controller.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    // ✅ StorageServices - pehle initialize karo
    Get.lazyPut<StorageServices>(() => StorageServices(), fenix: true);

    // ✅ CurrentUserIdServices - StorageServices ke baad
    Get.lazyPut<CurrentUserIdServices>(() => CurrentUserIdServices(), fenix: true);

    // ✅ LikeService
    Get.lazyPut<LikeService>(() => LikeService(), fenix: true);

    // ✅ ContactSellerService
    Get.lazyPut<ContactSellerService>(() => ContactSellerService(), fenix: true);

    // ✅ AuthController - Add this line
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);

    Get.lazyPut(() => GoogleAuthService());
  }
}