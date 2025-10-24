import 'package:get/get.dart';
import '../../../../data/models/notification/notification_model.dart';
import '../../../../data/repositories/notification/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository = NotificationRepository();

  var notifications = <Data>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  final int limit = 10;
  var unreadCount = 0.obs;
  var isMarkingRead = false.obs;
  var isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    fetchUnreadCount();
  }

  /// Fetch notifications with pagination
  Future<void> fetchNotifications({bool loadMore = false}) async {
    if (isLoading.value) return;

    if (!loadMore) {
      page.value = 1;
      notifications.clear();
      hasMore.value = true;
    }

    isLoading.value = true;

    final response = await _repository.fetchNotifications(
      page: page.value,
      limit: limit,
    );

    if (response != null) {
      if (response.success && response.data != null) {
        final notificationData = response.data!;

        // Append or replace notifications
        if (loadMore) {
          notifications.addAll(notificationData.data ?? []);
        } else {
          notifications.value = notificationData.data ?? [];
        }

        // Handle pagination
        final pagination = notificationData.pagination;
        if (pagination != null) {
          hasMore.value = page.value < pagination.pages!;
          page.value++;
        } else {
          hasMore.value = false;
        }

        // Update unread count locally
        updateUnreadCount();

      } else {
        // Error handling
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to load notifications',
          snackPosition: SnackPosition.BOTTOM,
        );
        if (loadMore) page.value--; // revert page on failure
      }
    } else {
      // Null response, handle error
      Get.snackbar(
        'Error',
        'Failed to load notifications',
        snackPosition: SnackPosition.BOTTOM,
      );
      if (loadMore) page.value--;
    }

    isLoading.value = false;
  }

  /// Fetch unread count from server
  Future<void> fetchUnreadCount() async {
    try {
      final response = await _repository.getUnreadCount();
      if (response != null && response.success) {
        unreadCount.value = response.data?['count'] ?? 0;
      }
    } catch (e) {
      print('Error fetching unread count: $e');
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(Data notification) async {
    if (notification.read == true) return;

    try {
      isMarkingRead.value = true;
      final response = await _repository.markAsRead(notification.id!);

      if (response != null && response.success) {
        // Update local notification
        final index = notifications.indexWhere((n) => n.id == notification.id);
        if (index != -1) {
          notifications[index] = notification.copyWith(read: true);
          updateUnreadCount();
          await fetchUnreadCount(); // Sync with server
        }
      } else {
        Get.snackbar(
          'Error',
          response?.message ?? 'Failed to mark as read',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to mark as read',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isMarkingRead.value = false;
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      isMarkingRead.value = true;
      final response = await _repository.markAllAsRead();

      if (response != null && response.success) {
        // Update all local notifications
        for (int i = 0; i < notifications.length; i++) {
          notifications[i] = notifications[i].copyWith(read: true);
        }
        unreadCount.value = 0;

        Get.snackbar(
          'Success',
          'All notifications marked as read',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          response?.message ?? 'Failed to mark all as read',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to mark all as read',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isMarkingRead.value = false;
    }
  }

  /// Delete single notification
  Future<void> deleteNotification(Data notification) async {
    try {
      isDeleting.value = true;
      final response = await _repository.deleteNotification(notification.id!);

      if (response != null && response.success) {
        notifications.removeWhere((n) => n.id == notification.id);
        updateUnreadCount();

        Get.snackbar(
          'Success',
          'Notification deleted',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          response?.message ?? 'Failed to delete notification',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete notification',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isDeleting.value = false;
    }
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    try {
      final response = await _repository.clearAllNotifications();

      if (response != null && response.success) {
        notifications.clear();
        unreadCount.value = 0;

        Get.snackbar(
          'Success',
          'All notifications cleared',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          response?.message ?? 'Failed to clear notifications',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear notifications',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Refresh notifications
  Future<void> refreshNotifications() async {
    await fetchNotifications(loadMore: false);
    await fetchUnreadCount();
  }

  /// Load more notifications
  void loadMoreNotifications() {
    if (hasMore.value && !isLoading.value) {
      fetchNotifications(loadMore: true);
    }
  }

  /// Update local unread count
  void updateUnreadCount() {
    unreadCount.value = notifications.where((n) => n.read == false).length;
  }

  /// Handle notification tap action
  void handleNotificationAction(Data notification) {
    // First mark as read
    markAsRead(notification);

    // Then handle action based on type and actionUrl
    if (notification.actionUrl != null && notification.actionUrl!.isNotEmpty) {
      // Navigate based on actionUrl
      // Example: Get.toNamed(notification.actionUrl!);
      print('Navigate to: ${notification.actionUrl}');
    }

    // Or handle based on type
    switch (notification.type?.toLowerCase()) {
      case 'property':
        if (notification.metadata?.propertyId != null) {
          Get.toNamed('/product/${notification.metadata!.propertyId}');
          print('Navigate to property: ${notification.metadata!.propertyId}');
        }
        break;
      case 'lead':
      // Get.toNamed('/leads');
        print('Navigate to leads');
        break;
      case 'chat':
      // Get.toNamed('/chat');
        print('Navigate to chat');
        break;
    }
  }

  /// Test method for local notification (if implemented)
  void testLocalNotification() {
    // This would require local notification service
    // _notificationService.showLocalNotification(...);
    Get.snackbar(
      'Test',
      'Local notification feature would be triggered here',
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void onClose() {
    _repository.cancelRequest();
    super.onClose();
  }
}

// Extension for copying Data object
extension DataCopyWith on Data {
  Data copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    String? type,
    bool? read,
    String? actionUrl,
    Metadata? metadata,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return Data(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      read: read ?? this.read,
      actionUrl: actionUrl ?? this.actionUrl,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }
}

/*
import 'package:get/get.dart';
import '../../../data/models/notification/notification_model.dart';
import '../../../data/repositories/notification/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository = NotificationRepository();

  var notifications = <Data>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  /// Fetch notifications with pagination
  void fetchNotifications({bool loadMore = false}) async {
    if (loadMore) page.value++;

    isLoading.value = true;

    final response = await _repository.fetchNotifications(
      page: page.value,
      limit: limit,
    );

    if (response != null) {
      if (response.success && response.data != null) {
        // Append or replace notifications
        if (loadMore) {
          notifications.addAll(response.data!.data ?? []);
        } else {
          notifications.value = response.data!.data ?? [];
        }
      } else {
        // Error handling: you can show a toast/snackbar here
        print('Notification fetch failed: ${response.message}');
        if (loadMore) page.value--; // revert page on failure
      }
    } else {
      // Null response, handle error
      print('Notification fetch returned null');
      if (loadMore) page.value--;
    }

    isLoading.value = false;
  }
}
*/



