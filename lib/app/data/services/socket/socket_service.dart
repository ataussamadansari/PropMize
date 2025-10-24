import 'package:get/get.dart';
import 'package:prop_mize/app/data/services/storage/storage_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  late IO.Socket socket;
  final StorageServices _storageServices = Get.find<StorageServices>();

  final RxBool isConnected = false.obs;
  final RxBool isConnecting = false.obs;
  final RxBool socketEnabled = false.obs; // ✅ Socket enable/disable control

  @override
  void onInit() {
    super.onInit();

    // ✅ Temporary: Socket disable karo jab tak backend ready nahi ho
    socketEnabled.value = true;

    if (socketEnabled.value) {
      initSocket();
    } else {
      print('🚫 Socket service disabled - Backend not ready');
    }
  }

  void initSocket() {
    if (!socketEnabled.value) {
      print('⏸️ Socket initialization skipped - disabled');
      return;
    }

    try {
      isConnecting.value = true;

      print('🔄 Attempting socket connection...');

      // ✅ Multiple URL options try karo
      final List<String> socketUrls = [
        'https://api.propmize.com',
        'https://api.propmize.com/api',
      ];

      String selectedUrl = socketUrls[0];
      bool connectionSuccess = false;

      for (final url in socketUrls) {
        try {
          print('🔗 Trying socket URL: $url');

          socket = IO.io(
            url,
            IO.OptionBuilder()
                .setTransports(['websocket', 'polling']) // ✅ Multiple transports
                .enableAutoConnect()
                .setQuery({
              'token': _storageServices.getToken() ?? '',
              'userId': _storageServices.getUserId() ?? '',
            })
                .setTimeout(10000) // 10 second timeout
                .build(),
          );

          // Setup basic listeners for this attempt
          _setupSocketListeners();
          selectedUrl = url;
          connectionSuccess = true;
          break; // Success milne par loop break karo

        } catch (e) {
          print('❌ Failed to connect to $url: $e');
          continue; // Next URL try karo
        }
      }

      if (!connectionSuccess) {
        print('💥 All socket connection attempts failed');
        isConnecting.value = false;
        socketEnabled.value = false; // Permanently disable
      }

    } catch (e) {
      print('❌ Socket Initialization Error: $e');
      isConnecting.value = false;
      socketEnabled.value = false;
    }
  }

  void _setupSocketListeners() {
    // Socket event listeners
    socket.onConnect((_) {
      print('✅ Socket Connected successfully!');
      isConnected.value = true;
      isConnecting.value = false;

      // User room join karo
      final userId = _storageServices.getUserId();
      if (userId != null) {
        socket.emit('join', userId);
        print('👤 Joined user room: $userId');
      }
    });

    socket.onDisconnect((_) {
      print('❌ Socket Disconnected');
      isConnected.value = false;
    });

    socket.onError((error) {
      print('❌ Socket Error: $error');
      isConnected.value = false;
      isConnecting.value = false;
    });

    socket.onConnectError((error) {
      print('❌ Socket Connect Error: $error');
      print('💡 This usually means the socket.io server is not running');
      isConnected.value = false;
      isConnecting.value = false;
    });

    // Connection timeout
    Future.delayed(const Duration(seconds: 10), () {
      if (!isConnected.value && isConnecting.value) {
        print('⏰ Socket connection timeout - server not responding');
        isConnecting.value = false;
        socketEnabled.value = false; // Disable further attempts
      }
    });
  }

  // Event listen karna
  void on(String event, Function(dynamic) handler) {
    if (socketEnabled.value && isConnected.value) {
      socket.on(event, handler);
    } else {
      print('⚠️ Cannot listen to $event - socket not available');
    }
  }

  // Event emit karna
  void emit(String event, dynamic data) {
    if (socketEnabled.value && isConnected.value) {
      socket.emit(event, data);
      print('📤 Emitted: $event');
    } else {
      print('⚠️ Cannot emit $event - socket not connected');
    }
  }

  // Socket manually enable karna
  void enableSocket() {
    if (!socketEnabled.value) {
      print('🔓 Manually enabling socket service');
      socketEnabled.value = true;
      initSocket();
    }
  }

  // Socket manually disable karna
  void disableSocket() {
    print('🔒 Manually disabling socket service');
    socketEnabled.value = false;
    disconnect();
  }

  // Socket disconnect karna
  void disconnect() {
    if (socketEnabled.value) {
      socket.disconnect();
      isConnected.value = false;
      print('🔌 Socket manually disconnected');
    }
  }

  // Socket reconnect karna
  void reconnect() {
    if (socketEnabled.value && !isConnected.value && !isConnecting.value) {
      print('🔄 Manual reconnect requested');
      socket.connect();
    }
  }

  // Status check
  void checkStatus() {
    print('🔍 Socket Service Status:');
    print('   - Enabled: ${socketEnabled.value}');
    print('   - Connected: ${isConnected.value}');
    print('   - Connecting: ${isConnecting.value}');
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}