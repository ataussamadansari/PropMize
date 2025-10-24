import 'package:get/get.dart';

import '../../data/services/auth/google_auth_service.dart';
import '../../data/services/contact_seller_service.dart';
import '../../data/services/like_services.dart';
import '../../data/services/socket/socket_notification_service.dart';
import '../../data/services/socket/socket_service.dart';
import '../../data/services/storage/current_user_id_services.dart';
import '../../data/services/storage/storage_services.dart';
import '../../modules/common_modules/auth_screen/controllers/auth_controller.dart';
import '../../modules/common_modules/notification_screen/controllers/notification_controller.dart';


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

    // ✅ Socket Services
    Get.lazyPut<SocketService>(() => SocketService(), fenix: true);

    // ✅ Socket Notification Service
    Get.lazyPut<SocketNotificationService>(() => SocketNotificationService(), fenix: true);

    // ✅ Notification Controller (SocketNotificationService ke baad)
    Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
  }
}