import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../../../core/utils/helpers.dart';
import '../../../repositories/notification/notification_repository.dart';
import '../../storage/storage_services.dart';
import '../v1/socket_service.dart';
import '../../../models/notification/notification_model.dart';

class SocketNotificationService extends GetxService
{
    final SocketService socketService = Get.find<SocketService>();
    final NotificationRepository repository = NotificationRepository();
    final StorageServices storageServices = Get.find<StorageServices>();

    // Simple state management
    final RxInt unreadCount = 0.obs;
    final RxList<Data> notifications = <Data>[].obs;
    final RxString serviceStatus = 'initializing'.obs;


    @override
    void onInit()
    {
        super.onInit();
        debugPrint("1. 🎯 NotificationService INIT");
        _initializeService();
    }

    void _initializeService()
    {
        debugPrint('2. 🔧 Initializing Notification Service...');
        serviceStatus.value = "initializing";

        // Step 1: Wait for socket connection
        _waitForSocketConnection();
    }

    void _waitForSocketConnection()
    {
        debugPrint('3. ⏳ Waiting for socket connection...');

        ever(socketService.isConnected, (connected)
            {
                if (connected)
                {
                    debugPrint('4. ✅ Socket Connected - Setting up notification system');
                    _setupNotificationSystem();
                }
                else
                {
                    debugPrint('5. ❌ Socket Disconnected - Pausing notification system');
                    serviceStatus.value = 'disconnected';
                }

                // If already connected, setup immediately
               /* if (socketService.isConnected.value)
                {
                    _setupNotificationSystem();
                }*/
            }
        );
    }

    void _setupNotificationSystem()
    {
        debugPrint('6. 📡 Setting up Notification System...');
        serviceStatus.value = "setting_up";

        // Step 1: Setup socket listeners
        _setupSocketListeners();

        // Step 2: Load initial data
        _loadInitialData();

        serviceStatus.value = "ready";
        debugPrint('7. 🎉 Notification Service is Ready');
    }

    void _setupSocketListeners()
    {
        debugPrint('8. 🎧 Setting up Socket Listeners...');

        // Remove any existing listeners first
        _removeSocketListeners();

        // Listen for new notifications
        socketService.listen('notification', (data)
            {
                debugPrint('9. 📩 New Notification Received: $data');
                _handleNewNotification(data);
            }
        );

        // Listen for read confirmations
        socketService.listen('notification:read', (data)
            {
                debugPrint('10. 📖 NOTIFICATION READ CONFIRMATION: $data');
                _handleReadConfirmation(data);
            }
        );

        // Listen for unread count updates
        socketService.listen('unread-count', (data)
            {
                debugPrint('11. 📊 UNREAD COUNT UPDATE: $data');
                _handleUnreadCountUpdate(data);
            }
        );

        socketService.listen('notification:delete', (data) {
            debugPrint('🗑️ NOTIFICATION DELETED: $data');
            _handleNotificationDelete(data);
        });

        debugPrint('12. ✅ Socket Listeners Setup Complete');
    }


    void _loadInitialData() async
    {
        debugPrint('13. 📥 Loading Initial Data...');

        try
        {
            // Load unread count first
            await _loadUnreadCount();

            // Then load notifications
            await _loadNotifications();

            debugPrint('14. ✅ Initial Data Loaded Successfully');
        }
        catch (e)
        {
            debugPrint('❌ Error loading initial data: $e');
        }
    }

    Future<void> _loadUnreadCount() async
    {
        debugPrint('15. 🔢 Loading Unread Count...');

        try
        {
            final response = await repository.getUnreadCount();
            debugPrint('📊 Raw API Response: ${response.data}');

            if (response.success && response.data != null) 
            {
                // ✅ NOW USE THE MODEL PROPERLY
                final unreadCountData = response.data!;

                if (unreadCountData.data != null && unreadCountData.data!.count != null) 
                {
                    unreadCount.value = unreadCountData.data!.count!;
                    debugPrint('16. ✅ Unread Count Loaded: ${unreadCount.value}');
                }
                else 
                {
                    debugPrint('16. ⚠️ Count is null in model');
                    unreadCount.value = 0;
                }
            }
            else 
            {
                debugPrint('16. ❌ API Response failed: ${response.message}');
                unreadCount.value = 0;
            }

            /*if (response.success && response.data != null)
            {
                // final count = response.data!['count'];
                // unreadCount.value = count;
                // debugPrint('16. ✅ Unread Count Loaded: $count');
            }*/
        }
        catch (e)
        {
            debugPrint('❌ Error loading unread count: $e');
        }
    }

    Future<void> _loadNotifications() async
    {
        debugPrint('17. 📋 Loading Notifications...');

        try
        {
            final response = await repository.fetchNotifications(page: 1, limit: 10);
            if (response.success && response.data != null)
            {
                notifications.value = response.data!.data!;
                debugPrint('18. ✅ Notifications Loaded: ${notifications.length}');
            }
        }
        catch (e)
        {
            debugPrint('❌ Error loading notifications: $e');
        }
    }

    void _handleNewNotification(dynamic data)
    {
        debugPrint('19. 🆕 Processing New Notification...');

        try
        {
            // Parse notification data
            final notification = _parseNotification(data);
            if (notification == null) return;

            // Add to notifications list
            notifications.insert(0, notification);

            // Update unread count if notification is unread
            if (!notification.read!)
            {
                unreadCount.value++;
                debugPrint('20. 📈 Unread Count Increased: ${unreadCount.value}');
            }

            // Show snackbar to user
            _showNotificationAlert(notification);

            debugPrint('21. ✅ New Notification Processed: ${notification.title}');
        }
        catch (e)
        {
            debugPrint('❌ Error processing new notification: $e');
        }
    }

    void _handleReadConfirmation(dynamic data)
    {
        debugPrint('22. ✅ Processing Read Confirmation...');

        try
        {
            if (data is Map)
            {
                final notificationId = data['id']?.toString();

                if (notificationId == 'all')
                {
                    // all notifications marked as read
                    unreadCount.value = 0;
                    debugPrint('23. ✅ All notifications marked as read');
                }
                else if (notificationId != null)
                {
                    // single notification marked as read
                    if (unreadCount.value > 0)
                    {
                        unreadCount.value--;
                        debugPrint('24. ✅ Notification $notificationId marked as read. Unread Count: ${unreadCount.value}');
                    }
                }
            }
        }
        catch (e)
        {
            debugPrint('❌ Error processing read confirmation: $e');
        }
    }

    void _handleUnreadCountUpdate(dynamic data)
    {
        debugPrint('25. 🔄 Processing Unread Count Update...');

        try
        {
            if (data is Map)
            {
                final count = data['count'] as int;
                if (count != null)
                {
                    unreadCount.value = count;
                    debugPrint('26. ✅ Unread Count Updated: $count');
                }
            }
        }
        catch (e)
        {
            debugPrint('❌ Error processing unread count update: $e');
        }
    }

    void _handleNotificationDelete(dynamic data) {
        try {
            if (data is Map) {
                final notificationId = data['id']?.toString();
                if (notificationId != null) {
                    notifications.removeWhere((n) => n.id == notificationId);
                    debugPrint('✅ Notification deleted: $notificationId');
                }
            }
        } catch (e) {
            debugPrint('❌ Error handling notification delete: $e');
        }
    }

    Data? _parseNotification(dynamic data)
    {
        try
        {
            if (data is! Map<String, dynamic>) return null;

            return Data(
                id: data['_id']?.toString(),
                userId: data['userId']?.toString(),
                title: data['title']?.toString(),
                message: data['message']?.toString(),
                type: data['type']?.toString(),
                read: data['read'] ?? false,
                actionUrl: data['actionUrl']?.toString(),
                metadata: data['metadata'] != null
                    ? Metadata.fromJson(Map<String, dynamic>.from(data['metadata']))
                    : null,
                createdAt: data['createdAt']?.toString()
            );
        }
        catch (e)
        {
            debugPrint('❌ Error parsing notification: $e');
            return null;
        }
    }

    void _showNotificationAlert(Data notification)
    {
        AppHelpers.showSnackBar(
            title: notification.title ?? "New Notification",
            message: notification.message ?? ""
        );
    }

    // PUBLIC METHODS
    Future<void> markAsRead(String notificationId) async
    {
        debugPrint('📖 Marking as read: $notificationId');

        try
        {
            socketService.send('notification:read',
                {
                    'id': notificationId,
                    'userId': storageServices.getUserId()
                }
            );

            final response = await repository.markAsRead(notificationId);

            if (response.success && response.data != null) 
            {
                await refreshData();
            }

            debugPrint('✅ Mark as read request sent: $notificationId');
        }
        catch (e)
        {
            debugPrint('❌ Error sending mark as read request: $e');
        }
    }

    Future<void> markAllAsRead() async
    {
        debugPrint('📖 Marking all as read');

        try
        {
            // Sent to server
            socketService.send('notification:read',
                {
                    'id': 'all',
                    'userId': storageServices.getUserId()
                }
            );

            final response = await repository.markAllAsRead();

            if (response.success && response.data != null) 
            {
                await refreshData();
            }

            debugPrint('✅ Mark all as read request sent');
        }
        catch (e)
        {
            debugPrint('❌ Error sending mark all as read request: $e');
        }
    }

    Future<void> refreshData() async
    {
        debugPrint('🔄 Refreshing notification data...');
        await _loadUnreadCount();
        await _loadNotifications();
    }

    void _removeSocketListeners()
    {
        socketService.socket.off('notification');
        socketService.socket.off('notification:read');
        socketService.socket.off('notification:delete');
        socketService.socket.off('unread-count');
    }

    void printStatus()
    {
        debugPrint('''
        🔍 NOTIFICATION SERVICE STATUS:
          - Service Status: ${serviceStatus.value}
          - Unread Count: ${unreadCount.value}
          - Notifications: ${notifications.length}
          - Socket Connected: ${socketService.isConnected.value}
        ''');
    }

    @override
    void onClose() 
    {
        debugPrint('🛑 NotificationService Closing...');
        super.onClose();
    }

}
