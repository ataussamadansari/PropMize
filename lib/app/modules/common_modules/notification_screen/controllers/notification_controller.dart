// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prop_mize/app/data/models/notification/notification_model.dart';
// import 'package:prop_mize/app/data/services/socket/socket_notification_service.dart';
//
// class NotificationController extends GetxController {
//   final SocketNotificationService _socketService = Get.find<SocketNotificationService>();
//
//   // Reactive state
//   var notifications = <Data>[].obs;
//   var isLoading = false.obs;
//   var hasMore = true.obs;
//   var page = 1.obs;
//   final int limit = 10;
//   var unreadCount = 0.obs;
//   var isMarkingRead = false.obs;
//   var isDeleting = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _setupSocketCallbacks();
//     _loadInitialData();
//   }
//
//   void _setupSocketCallbacks() {
//     _socketService.setupCallbacks(
//       onNotificationReceived: _handleNewNotification,
//       onNotificationRead: _handleNotificationRead,
//       onNotificationDeleted: _handleNotificationDelete,
//       onUnreadCountUpdate: _handleUnreadCountUpdate,
//     );
//   }
//
//   Future<void> _loadInitialData() async {
//     await _fetchNotifications();
//     await _socketService.fetchUnreadCount();
//   }
//
//   /// ✅ Handle new notification from backend
//   void _handleNewNotification(Data notification) {
//     try {
//       // Add to beginning of list
//       notifications.insert(0, notification);
//
//       print('📢 Real-time notification: ${notification.title}');
//
//       // Force UI update
//       notifications.refresh();
//
//     } catch (e) {
//       print('Error handling socket notification: $e');
//     }
//   }
//
//   /// ✅ Handle notification read confirmation from backend
//   void _handleNotificationRead(String notificationId) {
//     try {
//       if (notificationId == 'all') {
//         // Mark all as read
//         for (int i = 0; i < notifications.length; i++) {
//           notifications[i] = notifications[i].copyWith(read: true);
//         }
//       } else {
//         // Mark single as read
//         _updateNotificationReadStatus(notificationId, true);
//       }
//
//       notifications.refresh();
//       print('✅ Backend confirmed read: $notificationId');
//
//     } catch (e) {
//       print('Error handling socket read: $e');
//     }
//   }
//
//   /// ✅ Handle notification delete confirmation from backend
//   void _handleNotificationDelete(String notificationId) {
//     try {
//       _removeNotification(notificationId);
//       print('✅ Backend confirmed delete: $notificationId');
//     } catch (e) {
//       print('Error handling socket delete: $e');
//     }
//   }
//
//   /// ✅ Handle unread count update from backend
//   void _handleUnreadCountUpdate(int count) {
//     unreadCount.value = count;
//     print('📊 Unread count updated: $count');
//   }
//
//   /// ✅ Fetch notifications from API
//   Future<void> _fetchNotifications({bool loadMore = false}) async {
//     if (isLoading.value) return;
//
//     if (!loadMore) {
//       page.value = 1;
//       notifications.clear();
//       hasMore.value = true;
//     }
//
//     isLoading.value = true;
//
//     try {
//       final notificationsList = await _socketService.fetchNotifications(
//         page: page.value,
//         limit: limit,
//       );
//
//       if (loadMore) {
//         notifications.addAll(notificationsList);
//       } else {
//         notifications.value = notificationsList;
//       }
//
//       hasMore.value = notificationsList.length == limit;
//       page.value++;
//
//       print('✅ Notifications loaded: ${notifications.length}');
//
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to load notifications',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       if (loadMore) page.value--;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// ✅ Mark as read - Backend compatible
//   /*Future<void> markAsRead(Data notification) async {
//     if (notification.read == true) return;
//
//     try {
//       isMarkingRead.value = true;
//
//       // Immediate UI update
//       _updateNotificationReadStatus(notification.id!, true);
//
//       // Backend ko inform karo
//       await _socketService.markAsRead(notification.id!);
//
//       print('✅ Mark as read: ${notification.id}');
//
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to mark as read',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isMarkingRead.value = false;
//     }
//   }*/
//
//   /// ✅ Mark as read - Backend compatible
//   Future<void> markAsRead(Data notification) async {
//     if (notification.read == true) return;
//
//     try {
//       isMarkingRead.value = true;
//
//       // Immediate UI update - Optimistic update
//       _updateNotificationReadStatus(notification.id!, true);
//       unreadCount.value = unreadCount.value > 0 ? unreadCount.value - 1 : 0;
//
//       // Backend ko inform karo
//       await _socketService.markAsRead(notification.id!);
//
//       print('✅ Mark as read: ${notification.id}');
//
//     } catch (e) {
//       // Revert optimistic update on error
//       _updateNotificationReadStatus(notification.id!, false);
//       unreadCount.value = unreadCount.value + 1;
//
//       Get.snackbar(
//         'Error',
//         'Failed to mark as read',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isMarkingRead.value = false;
//     }
//   }
//
//   /// ✅ Mark all as read - Backend compatible
//   Future<void> markAllAsRead() async {
//     try {
//       isMarkingRead.value = true;
//
//       // Backend ko inform karo
//       await _socketService.markAllAsRead();
//
//       // Immediate UI update
//       for (int i = 0; i < notifications.length; i++) {
//         if (!notifications[i].read!) {
//           notifications[i] = notifications[i].copyWith(read: true);
//         }
//       }
//       notifications.refresh();
//
//       print('✅ Mark all as read');
//
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to mark all as read',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isMarkingRead.value = false;
//     }
//   }
//
//   /// ✅ Delete notification - Backend compatible
//   Future<void> deleteNotification(Data notification) async {
//     try {
//       isDeleting.value = true;
//
//       // Backend ko inform karo
//       await _socketService.deleteNotification(notification.id!);
//
//       // Immediate UI update
//       _removeNotification(notification.id!);
//
//       print('✅ Delete notification: ${notification.id}');
//
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to delete notification',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isDeleting.value = false;
//     }
//   }
//
//   /// Refresh notifications
//   Future<void> refreshNotifications() async {
//     await _fetchNotifications(loadMore: false);
//     await _socketService.fetchUnreadCount();
//   }
//
//   /// Load more notifications
//   void loadMoreNotifications() {
//     if (hasMore.value && !isLoading.value) {
//       _fetchNotifications(loadMore: true);
//     }
//   }
//
//   // Helper methods
//   void _updateNotificationReadStatus(String notificationId, bool isRead) {
//     final index = notifications.indexWhere((n) => n.id == notificationId);
//     if (index != -1) {
//       notifications[index] = notifications[index].copyWith(read: isRead);
//     }
//   }
//
//   void _removeNotification(String notificationId) {
//     notifications.removeWhere((n) => n.id == notificationId);
//   }
//
//   // Navigation
//   void goToProductDetails(String propertyId) {
//     Get.toNamed('/product/$propertyId');
//   }
//
//   void handleNotificationAction(Data notification) {
//     // Mark as read first
//     markAsRead(notification);
//
//     // Then navigate if needed
//     if (notification.metadata?.propertyId != null) {
//       goToProductDetails(notification.metadata!.propertyId!);
//     }
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
//
// // Extension for copying Data object
// extension DataCopyWith on Data {
//   Data copyWith({
//     String? id,
//     String? userId,
//     String? title,
//     String? message,
//     String? type,
//     bool? read,
//     String? actionUrl,
//     Metadata? metadata,
//     String? createdAt,
//     String? updatedAt,
//     int? v,
//   }) {
//     return Data(
//       id: id ?? this.id,
//       userId: userId ?? this.userId,
//       title: title ?? this.title,
//       message: message ?? this.message,
//       type: type ?? this.type,
//       read: read ?? this.read,
//       actionUrl: actionUrl ?? this.actionUrl,
//       metadata: metadata ?? this.metadata,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       v: v ?? this.v,
//     );
//   }
// }