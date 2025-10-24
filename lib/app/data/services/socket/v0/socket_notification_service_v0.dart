import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/notification/notification_model.dart';
import 'package:prop_mize/app/data/services/socket/socket_service.dart';
import 'package:prop_mize/app/data/repositories/notification/notification_repository.dart';

class SocketNotificationService extends GetxService {
  final SocketService _socketService = Get.find<SocketService>();
  final NotificationRepository _repository = NotificationRepository();

  final RxBool isListening = false.obs;
  final RxBool isConnected = false.obs;

  // Callbacks for controller to implement
  Function(Data)? onNotificationReceived;
  Function(String, bool)? onNotificationRead;
  Function(String)? onNotificationDeleted;

  @override
  void onInit() {
    super.onInit();
    _setupConnectionListeners();
    setupSocketListeners();
  }

  void _setupConnectionListeners() {
    // Socket connection status track karo
    _socketService.isConnected.listen((connected) {
      isConnected.value = connected;
      if (connected && !isListening.value) {
        setupSocketListeners();
      } else {
        _removeSocketListeners();
        isListening.value = false;
      }
    });
  }

  void setupSocketListeners() {
    if (!_socketService.isConnected.value) {
      print('❌ Socket not connected, skipping listener setup');
      return;
    }

    print('🔄 Setting up socket notification listeners...');

    // Remove existing listeners first to avoid duplicates
    _removeSocketListeners();


    // ✅ New notification aane par
    _socketService.on('notification', (data) {
      print('📨 New notification received: $data');

      try {
        // ✅ Better data parsing with null safety
        if (data is! Map<String, dynamic>) {
          print('❌ Invalid notification data format');
          return;
        }

        // ✅ Convert socket data to match API response structure
        final notificationData = Data(
          id: data['_id']?.toString() ?? data['id']?.toString(),
          userId: data['userId']?.toString(),
          title: data['title']?.toString(),
          message: data['message']?.toString(),
          type: data['type']?.toString(),
          read: data['read'] ?? false,
          actionUrl: data['actionUrl']?.toString(),
          metadata: data['metadata'] != null
              ? Metadata.fromJson(Map<String, dynamic>.from(data['metadata']))
              : null,
          createdAt: data['timestamp']?.toString() ?? data['createdAt']?.toString(),
          updatedAt: data['updatedAt']?.toString(),
        );

        // ✅ Validate required fields
        if (notificationData.id == null) {
          print('❌ Notification missing ID, skipping');
          return;
        }

        print('✅ Parsed notification: ${notificationData.title}');

        // Callback through controller ko inform karo
        if (onNotificationReceived != null) {
          onNotificationReceived!(notificationData);
        } else {
          print('⚠️ onNotificationReceived callback not set');
        }

        // ✅ Local notification show karo
        _showLocalNotification(notificationData);

        // ✅ Snackbar show karo only if app in foreground
        if (Get.isSnackbarOpen) {
          Get.back(); // Close existing snackbar
        }

        Get.snackbar(
          notificationData.title ?? 'New Notification',
          notificationData.message ?? '',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          onTap: (_) {
            // Optional: Navigate to notification screen
            Get.back(); // Close snackbar
          },
        );

      } catch (e) {
        print('❌ Error processing notification: $e');
        print('📦 Raw data: $data');
      }
    });

    // ✅ Notification read hone par (Server-side update) - REMOVE REPOSITORY CALL
    _socketService.on('notification:read', (data) async {
      print('📖 Notification read via socket: $data');

      try {
        final notificationId = data is Map ? data['id']?.toString() : data.toString();
        if (notificationId != null) {
          // ❌ YEH REPOSITORY CALL HATA DO - Loop create karega
          await _repository.markAsRead(notificationId);

          // ✅ Direct callback call karo
          if (onNotificationRead != null) {
            onNotificationRead!(notificationId, true);
          }

          print('✅ Notification read callback called: $notificationId');
        }
      } catch (e) {
        print('❌ Error processing notification read: $e');
      }
    });

    // ✅ Notification delete hone par (Server-side update)
    _socketService.on('notification:delete', (data) async {
      print('🗑️ Notification deleted via socket: $data');

      try {
        final notificationId = data is Map ? data['id']?.toString() : data.toString();
        if (notificationId != null) {
          // ✅ Sync with repository
          await _repository.deleteNotification(notificationId);

          // Callback through controller ko inform karo
          if (onNotificationDeleted != null) {
            onNotificationDeleted!(notificationId);
          }

          print('✅ Notification deleted: $notificationId');
        }
      } catch (e) {
        print('❌ Error processing notification delete: $e');
      }
    });

    // ✅ Mark all as read via socket
    _socketService.on('notification:read-all', (data) async {
      print('📚 All notifications read via socket');

      try {
        // ✅ Sync with repository
        await _repository.markAllAsRead();

        // Callback through controller ko inform karo
        if (onNotificationRead != null) {
          // Send null as ID to indicate all notifications
          onNotificationRead!('all', true);
        }

        print('✅ All notifications marked as read');
      } catch (e) {
        print('❌ Error processing all notifications read: $e');
      }
    });

    isListening.value = true;
    print('✅ Socket notification listeners setup completed');
  }

  void _removeSocketListeners() {
    _socketService.socket.off('notification');
    _socketService.socket.off('notification:read');
    _socketService.socket.off('notification:delete');
    _socketService.socket.off('notification:read-all');
  }

  void _showLocalNotification(Data notification) {
    // Yahan aap local notification show kar sakte hain
    print('🔔 Show local notification: ${notification.title}');
  }

  // ✅ Improved Manual emit methods with repository sync
  Future<void> markAsRead(String notificationId) async {
    try {
      if (isConnected.value) {
        // ✅ Only socket emit karo, repository call avoid karo (loop banega)
        _socketService.emit('notification:read', {'id': notificationId});
        print('✅ Notification read emitted via socket: $notificationId');
      } else {
        // ✅ Socket nahi hai toh direct API use karo
        await _repository.markAsRead(notificationId);
        print('✅ Notification marked as read via API: $notificationId');
      }
    } catch (e) {
      print('❌ Error marking as read: $e');
      // Fallback to API only
      await _repository.markAsRead(notificationId);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      if (isConnected.value) {
        // ✅ Only socket emit karo
        _socketService.emit('notification:read-all', {});
        print('✅ All notifications read emitted via socket');
      } else {
        // ✅ Socket nahi hai toh direct API use karo
        await _repository.markAllAsRead();
        print('✅ All notifications marked as read via API');
      }
    } catch (e) {
      print('❌ Error marking all as read: $e');
      // Fallback to API only
      await _repository.markAllAsRead();
    }
  }


  /*// ✅ Improved Manual emit methods with repository sync
  Future<void> markAsRead(String notificationId) async {
    if (isConnected.value) {
      try {
        // ✅ Pehle socket through emit karo
        _socketService.emit('notification:read', {'id': notificationId});

        // ✅ Phir repository se sync karo (fallback)
        final response = await _repository.markAsRead(notificationId);
        if (response.success) {
          print('✅ Notification marked as read via socket & API: $notificationId');
        } else {
          print('⚠️ Socket success but API failed for: $notificationId');
        }
      } catch (e) {
        print('❌ Error marking as read: $e');
        // Fallback to API only
        await _repository.markAsRead(notificationId);
      }
    } else {
      print('🔌 Socket not connected, using API only');
      // Fallback to API
      await _repository.markAsRead(notificationId);
    }
  }*/

  Future<void> deleteNotification(String notificationId) async {
    if (isConnected.value) {
      try {
        // ✅ Pehle socket through emit karo
        _socketService.emit('notification:delete', {'id': notificationId});

        // ✅ Phir repository se sync karo (fallback)
        final response = await _repository.deleteNotification(notificationId);
        if (response.success) {
          print('✅ Notification deleted via socket & API: $notificationId');
        } else {
          print('⚠️ Socket success but API failed for: $notificationId');
        }
      } catch (e) {
        print('❌ Error deleting notification: $e');
        // Fallback to API only
        await _repository.deleteNotification(notificationId);
      }
    } else {
      print('🔌 Socket not connected, using API only');
      // Fallback to API
      await _repository.deleteNotification(notificationId);
    }
  }

  /*Future<void> markAllAsRead() async {
    if (isConnected.value) {
      try {
        // ✅ Pehle socket through emit karo
        _socketService.emit('notification:read-all', {});

        // ✅ Phir repository se sync karo (fallback)
        final response = await _repository.markAllAsRead();
        if (response.success) {
          print('✅ All notifications marked as read via socket & API');
        } else {
          print('⚠️ Socket success but API failed for mark all read');
        }
      } catch (e) {
        print('❌ Error marking all as read: $e');
        // Fallback to API only
        await _repository.markAllAsRead();
      }
    } else {
      print('🔌 Socket not connected, using API only');
      // Fallback to API
      await _repository.markAllAsRead();
    }
  }*/

  // ✅ Reconnect aur setup listeners
  void reconnect() {
    if (_socketService.isConnected.value) {
      setupSocketListeners();
    } else {
      _socketService.reconnect();
    }
  }

  // ✅ Get real-time unread count from server
  Future<int> getRealTimeUnreadCount() async {
    try {
      final response = await _repository.getUnreadCount();
      if (response.success) {
        return response.data?['count'] ?? 0;
      }
    } catch (e) {
      print('❌ Error fetching real-time unread count: $e');
    }
    return 0;
  }

  // ✅ Setup callbacks from controller
  void setupCallbacks({
    Function(Data)? onNotificationReceived,
    Function(String, bool)? onNotificationRead,
    Function(String)? onNotificationDeleted,
  }) {
    this.onNotificationReceived = onNotificationReceived;
    this.onNotificationRead = onNotificationRead;
    this.onNotificationDeleted = onNotificationDeleted;
  }

  // ✅ Status check method
  void checkStatus() {
    print('=== SOCKET NOTIFICATION SERVICE STATUS ===');
    print('Connected: ${isConnected.value}');
    print('Listening: ${isListening.value}');
    print('Socket Enabled: ${_socketService.socketEnabled.value}');
    print('==========================================');
  }

  @override
  void onClose() {
    _removeSocketListeners();
    isListening.value = false;
    super.onClose();
  }
}


/*
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/notification/notification_model.dart';
import 'package:prop_mize/app/data/services/socket/socket_service.dart';

class SocketNotificationService extends GetxService {
  final SocketService _socketService = Get.find<SocketService>();

  final RxBool isListening = false.obs;
  final RxBool isConnected = false.obs;

  // Callbacks for controller to implement
  Function(Data)? onNotificationReceived;
  Function(String, bool)? onNotificationRead;
  Function(String)? onNotificationDeleted;

  @override
  void onInit() {
    super.onInit();
    _setupConnectionListeners();
    setupSocketListeners();
  }


  void _setupConnectionListeners() {
    // Socket connection status track karo
    _socketService.isConnected.listen((connected) {
      isConnected.value = connected;
      if (connected && !isListening.value) {
        setupSocketListeners();
      }
    });
  }

  void setupSocketListeners() {
    if (!_socketService.isConnected.value) {
      print('Socket not connected, skipping listener setup');
      return;
    }

    print('Setting up socket notification listeners...');

    // Remove existing listeners first to avoid duplicates
    _removeSocketListeners();

    // New notification aane par
    _socketService.on('notification', (data) {
      print('New notification received: $data');

      try {
        // Data ko Notification model me convert karo
        final notification = Data.fromJson(data);

        // Callback through controller ko inform karo
        if (onNotificationReceived != null) {
          onNotificationReceived!(notification);
        }

        // Local notification show karo (agar app background me ho)
        _showLocalNotification(notification);

        // Snackbar show karo user ko inform karne ke liye
        Get.snackbar(
          notification.title ?? 'New Notification',
          notification.message ?? '',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );

      } catch (e) {
        print('Error processing notification: $e');
      }
    });

    // Notification read hone par
    _socketService.on('notification:read', (data) {
      print('Notification read: $data');

      try {
        final notificationId = data is Map ? data['id'] : data.toString();
        if (notificationId != null) {
          // Callback through controller ko inform karo
          if (onNotificationRead != null) {
            onNotificationRead!(notificationId, true);
          }
        }
      } catch (e) {
        print('Error processing notification read: $e');
      }
    });

    // Notification delete hone par
    _socketService.on('notification:delete', (data) {
      print('Notification deleted: $data');

      try {
        final notificationId = data is Map ? data['id'] : data.toString();
        if (notificationId != null) {
          // Callback through controller ko inform karo
          if (onNotificationDeleted != null) {
            onNotificationDeleted!(notificationId);
          }
        }
      } catch (e) {
        print('Error processing notification delete: $e');
      }
    });

    isListening.value = true;
    print('Socket notification listeners setup completed');
  }

  void _removeSocketListeners() {
    _socketService.socket.off('notification');
    _socketService.socket.off('notification:read');
    _socketService.socket.off('notification:delete');
  }

  void _showLocalNotification(Data notification) {
    // Yahan aap local notification show kar sakte hain
    print('Show local notification: ${notification.title}');
  }

  // Manual emit methods (agar needed ho)
  void markAsRead(String notificationId) {
    if (isConnected.value) {
      _socketService.emit('notification:read', {'id': notificationId});
    } else {
      print('Socket not connected, cannot mark as read via socket');
    }
  }

  void deleteNotification(String notificationId) {
    if (isConnected.value) {
      _socketService.emit('notification:delete', {'id': notificationId});
    } else {
      print('Socket not connected, cannot delete via socket');
    }
  }

  // Reconnect aur setup listeners
  void reconnect() {
    if (_socketService.isConnected.value) {
      setupSocketListeners();
    } else {
      _socketService.reconnect();
    }
  }

  // Setup callbacks from controller
  void setupCallbacks({
    Function(Data)? onNotificationReceived,
    Function(String, bool)? onNotificationRead,
    Function(String)? onNotificationDeleted,
  }) {
    this.onNotificationReceived = onNotificationReceived;
    this.onNotificationRead = onNotificationRead;
    this.onNotificationDeleted = onNotificationDeleted;
  }

  @override
  void onClose() {
    _removeSocketListeners();
    isListening.value = false;
    super.onClose();
  }
}*/
