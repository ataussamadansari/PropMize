// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:prop_mize/app/data/models/notification/notification_model.dart';
// import 'package:prop_mize/app/data/services/socket/socket_service.dart';
// import 'package:prop_mize/app/data/repositories/notification/notification_repository.dart';
//
// import '../storage/storage_services.dart';
//
// class SocketNotificationService extends GetxService {
//   final SocketService _socketService = Get.find<SocketService>();
//   final NotificationRepository _repository = NotificationRepository();
//   final StorageServices _storageServices = Get.find<StorageServices>();
//
//   final RxBool isListening = false.obs;
//   final RxBool isConnected = false.obs;
//
//   // Real-time data
//   final RxInt notificationCount = 0.obs;
//   final RxInt unreadCount = 0.obs;
//   Timer? _monitorTimer;
//
//   // Callbacks for controller
//   Function(Data)? onNotificationReceived;
//   Function(String)? onNotificationRead;
//   Function(String)? onNotificationDeleted;
//   Function(int)? onUnreadCountUpdate;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _setupConnectionListeners();
//     setupSocketListeners();
//     _startMonitoring();
//     _initializeUnreadCount();
//   }
//
//   void _setupConnectionListeners() {
//     _socketService.isConnected.listen((connected) {
//       isConnected.value = connected;
//       if (connected && !isListening.value) {
//         setupSocketListeners();
//         _fetchUnreadCount();
//       } else {
//         _removeSocketListeners();
//         isListening.value = false;
//       }
//     });
//   }
//
//   // ✅ Backend compatible socket listeners
//   void setupSocketListeners() {
//     if (!_socketService.isConnected.value) return;
//
//     print('🔄 Setting up notification listeners...');
//
//     _removeSocketListeners();
//
//     // ✅ "notification" event - Backend se aata hai
//     _socketService.on('notification', (data) {
//       _handleNotification(data);
//     });
//
//     // ✅ "notification:read" event - Backend se confirmation
//     _socketService.on('notification:read', (data) {
//       _handleNotificationRead(data);
//     });
//
//     // ✅ "notification:delete" event - Backend se confirmation
//     _socketService.on('notification:delete', (data) {
//       _handleNotificationDelete(data);
//     });
//
//     // ✅ "unread-count" event - Backend se count update
//     _socketService.on('unread-count', (data) {
//       _handleUnreadCountUpdate(data);
//     });
//
//     isListening.value = true;
//     print('✅ Notification listeners active');
//   }
//
//   void _handleNotification(dynamic data) {
//     print('📨 Notification received from backend: $data');
//     notificationCount.value++;
//
//     try {
//       if (data is! Map<String, dynamic>) return;
//
//       // ✅ Backend data structure ke hisab se parse karo
//       final notificationData = Data(
//         id: data['_id']?.toString(),
//         userId: data['userId']?.toString(),
//         title: data['title']?.toString(),
//         message: data['message']?.toString(),
//         type: data['type']?.toString(),
//         read: data['read'] ?? false,
//         actionUrl: data['actionUrl']?.toString(),
//         metadata: data['metadata'] != null
//             ? Metadata.fromJson(Map<String, dynamic>.from(data['metadata']))
//             : null,
//         createdAt: data['createdAt']?.toString(),
//       );
//
//       if (notificationData.id == null) return;
//
//       // Controller ko inform karo
//       if (onNotificationReceived != null) {
//         onNotificationReceived!(notificationData);
//       }
//
//       // ✅ Unread count update karo
//       if (!notificationData.read!) {
//         unreadCount.value++;
//         _notifyUnreadCountUpdate();
//       }
//
//       // User ko dikhao
//       _showNotificationSnackbar(notificationData);
//
//     } catch (e) {
//       print('❌ Notification processing error: $e');
//     }
//   }
//
//   void _handleNotificationRead(dynamic data) {
//     try {
//       // ✅ Backend se notification ID aata hai
//       final notificationId = data is Map ? data['id']?.toString() : data.toString();
//
//       if (notificationId != null && onNotificationRead != null) {
//         onNotificationRead!(notificationId);
//
//         // ✅ Unread count update karo
//         if (notificationId == 'all') {
//           unreadCount.value = 0;
//         } else {
//           unreadCount.value = unreadCount.value > 0 ? unreadCount.value - 1 : 0;
//         }
//         _notifyUnreadCountUpdate();
//
//         print('✅ Notification read confirmed: $notificationId');
//       }
//     } catch (e) {
//       print('❌ Notification read error: $e');
//     }
//   }
//
//   void _handleNotificationDelete(dynamic data) {
//     try {
//       // ✅ Backend se notification ID aata hai
//       final notificationId = data is Map ? data['id']?.toString() : data.toString();
//
//       if (notificationId != null && onNotificationDeleted != null) {
//         onNotificationDeleted!(notificationId);
//         print('✅ Notification delete confirmed: $notificationId');
//
//         // ✅ Delete ke baad count refresh karo
//         _fetchUnreadCount();
//       }
//     } catch (e) {
//       print('❌ Notification delete error: $e');
//     }
//   }
//
//   void _handleUnreadCountUpdate(dynamic data) {
//     try {
//       if (data is Map<String, dynamic>) {
//         // ✅ Backend se count aata hai
//         final count = data['count'] as int?;
//         if (count != null) {
//           unreadCount.value = count;
//           _notifyUnreadCountUpdate();
//           print('📊 Unread count updated from backend: $count');
//         }
//       }
//     } catch (e) {
//       print('❌ Unread count update error: $e');
//     }
//   }
//
//   void _notifyUnreadCountUpdate() {
//     if (onUnreadCountUpdate != null) {
//       onUnreadCountUpdate!(unreadCount.value);
//     }
//   }
//
//   // ✅ Initial unread count load
//   Future<void> _initializeUnreadCount() async {
//     try {
//       final response = await _repository.getUnreadCount();
//       if (response.success && response.data != null) {
//         unreadCount.value = response.data!['count'] ?? 0;
//         _notifyUnreadCountUpdate();
//         print('📊 Initial unread count loaded: ${unreadCount.value}');
//       }
//     } catch (e) {
//       print('❌ Error loading initial unread count: $e');
//     }
//   }
//
//   // ✅ Unread count fetch - Backend compatible
//   Future<void> _fetchUnreadCount() async {
//     try {
//       if (isConnected.value) {
//         // ✅ Backend compatible event - get-unread-count
//         _socketService.emit('get-unread-count', {
//           'userId': _storageServices.getUserId(),
//         });
//         print('📊 Fetching unread count from backend...');
//       } else {
//         // Fallback to API
//         await _fetchUnreadCountFromAPI();
//       }
//     } catch (e) {
//       print('❌ Error fetching unread count: $e');
//       await _fetchUnreadCountFromAPI();
//     }
//   }
//
//   Future<void> _fetchUnreadCountFromAPI() async {
//     try {
//       final response = await _repository.getUnreadCount();
//       if (response.success && response.data != null) {
//         unreadCount.value = response.data!['count'] ?? 0;
//         _notifyUnreadCountUpdate();
//       }
//     } catch (e) {
//       print('❌ Error fetching unread count from API: $e');
//     }
//   }
//
//   void _showNotificationSnackbar(Data notification) {
//     if (Get.isSnackbarOpen) Get.back();
//
//     Get.snackbar(
//       notification.title ?? 'New Notification',
//       notification.message ?? '',
//       snackPosition: SnackPosition.TOP,
//       duration: const Duration(seconds: 3),
//     );
//   }
//
//   void _removeSocketListeners() {
//     _socketService.socket.off('notification');
//     _socketService.socket.off('notification:read');
//     _socketService.socket.off('notification:delete');
//     _socketService.socket.off('unread-count');
//   }
//
//   void _startMonitoring() {
//     _monitorTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
//       _logMonitoringStatus();
//     });
//   }
//
//   void _logMonitoringStatus() {
//     print('👁️ Notification Monitor:');
//     print('   - Connected: ${isConnected.value}');
//     print('   - Listening: ${isListening.value}');
//     print('   - Notifications: ${notificationCount.value}');
//     print('   - Unread: ${unreadCount.value}');
//   }
//
//   // ✅ PUBLIC METHODS - Backend Compatible
//
//   Future<void> markAsRead(String notificationId) async {
//     try {
//       if (isConnected.value) {
//         // ✅ Backend compatible event - notification:read
//         _socketService.emit('notification:read', {
//           'id': notificationId,
//           'userId': _storageServices.getUserId(),
//         });
//         print('✅ Mark as read sent to backend: $notificationId');
//       } else {
//         // Fallback to API
//         await _repository.markAsRead(notificationId);
//         print('✅ Mark as read via API: $notificationId');
//       }
//
//       // Optimistic update
//       unreadCount.value = unreadCount.value > 0 ? unreadCount.value - 1 : 0;
//       _notifyUnreadCountUpdate();
//
//     } catch (e) {
//       print('❌ Error marking as read: $e');
//     }
//   }
//
//   Future<void> markAllAsRead() async {
//     try {
//       // ✅ Backend compatible - Sab notifications ko read mark karo
//       // Note: Backend mein "notification:read-all" event check karo
//       // Agar nahi hai toh individual mark karo
//
//       if (isConnected.value) {
//         // Individual notifications ko read mark karo
//         // Ya phir backend se pucho koi bulk method hai kya
//         _socketService.emit('notification:read', {
//           'id': 'all',
//           'userId': _storageServices.getUserId(),
//         });
//         print('✅ Mark all as read sent to backend');
//       } else {
//         await _repository.markAllAsRead();
//         print('✅ Mark all as read via API');
//       }
//
//       // Optimistic update
//       unreadCount.value = 0;
//       _notifyUnreadCountUpdate();
//
//     } catch (e) {
//       print('❌ Error marking all as read: $e');
//     }
//   }
//
//   Future<void> deleteNotification(String notificationId) async {
//     try {
//       if (isConnected.value) {
//         // ✅ Backend compatible event - notification:delete
//         _socketService.emit('notification:delete', {
//           'id': notificationId,
//           'userId': _storageServices.getUserId(),
//         });
//         print('✅ Delete notification sent to backend: $notificationId');
//       } else {
//         await _repository.deleteNotification(notificationId);
//         print('✅ Delete notification via API: $notificationId');
//       }
//
//       // Refresh count
//       await _fetchUnreadCount();
//
//     } catch (e) {
//       print('❌ Error deleting notification: $e');
//     }
//   }
//
//   // Fetch notifications from API
//   Future<List<Data>> fetchNotifications({int page = 1, int limit = 10}) async {
//     try {
//       final response = await _repository.fetchNotifications(
//           page: page,
//           limit: limit
//       );
//       if (response.success && response.data != null) {
//         return response.data!.data ?? [];
//       }
//       return [];
//     } catch (e) {
//       print('❌ Error fetching notifications: $e');
//       return [];
//     }
//   }
//
//   void setupCallbacks({
//     Function(Data)? onNotificationReceived,
//     Function(String)? onNotificationRead,
//     Function(String)? onNotificationDeleted,
//     Function(int)? onUnreadCountUpdate,
//   }) {
//     this.onNotificationReceived = onNotificationReceived;
//     this.onNotificationRead = onNotificationRead;
//     this.onNotificationDeleted = onNotificationDeleted;
//     this.onUnreadCountUpdate = onUnreadCountUpdate;
//   }
//
//   Future<void> fetchUnreadCount() async {
//     await _fetchUnreadCount();
//   }
//
//   @override
//   void onClose() {
//     _monitorTimer?.cancel();
//     _removeSocketListeners();
//     super.onClose();
//   }
//
// }