import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../data/models/notification/notification_model.dart';
import '../../../../../data/services/socket/v1/socket_notification_service.dart';

class NotificationController extends GetxController {
  final SocketNotificationService notificationService = Get.find<SocketNotificationService>();

  // Get reactive data
  RxInt get unreadCount => notificationService.unreadCount;
  RxList<Data> get notifications => notificationService.notifications;

  @override
  void onInit() {
    super.onInit();
    debugPrint('NotificationController initialized');
  }

  void markAsRead(String notificationId) {
    notificationService.markAsRead(notificationId);
  }

  void markAllAsRead() {
    notificationService.markAllAsRead();
  }

  void refreshNotification() {
    notificationService.refreshData();
  }

  void printStatus() {
    notificationService.printStatus();
  }
}