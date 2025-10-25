import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/services/storage/storage_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService
{
    late IO.Socket socket;
    final StorageServices _storageServices = StorageServices();

    // Status tracking
    final RxBool isConnected = false.obs;
    final RxBool isConnecting = false.obs;
    final RxString connectionStatus = 'disconnected'.obs;

    @override
    void onInit()
    {
        super.onInit();
        debugPrint('1. 🎯 SocketService INIT');
        _initializeSocket();
    }

    void _initializeSocket()
    {
        debugPrint('2. 🔧 Initializing Socket Connection...');

        isConnecting.value = true;
        connectionStatus.value = "connecting";

        try
        {
            // Step 1: Create socket instance
            socket = IO.io(
                'https://api.propmize.com',
                IO.OptionBuilder()
                    .setTransports(['websocket', 'polling'])
                    .enableAutoConnect()
                    .setQuery(
                    {
                        'token': _storageServices.getToken() ?? '',
                        'userId': _storageServices.getUserId() ?? ''
                    }
                    )
                    .setTimeout(30000)
                    .build()
            );

            debugPrint('3. ✅ Socket Instance Created');

            // Step 2: Setup event listeners
            _setupEventListeners();

            // Step 3: Manually connect
            socket.connect();
        }
        catch (e)
        {
            debugPrint("❌ Socket Initialization Error: $e");
        }
        finally
        {
            isConnecting.value = false;
            connectionStatus.value = isConnected.value ? "connected" : "disconnected";
        }
    }

    void _setupEventListeners()
    {
        debugPrint('4. 📡 Setting up Socket Event Listeners...');

        // Connection Events
        socket.onConnect((_)
            {
                debugPrint('5. ✅ SOCKET CONNECTED SUCCESSFULLY!');
                isConnected.value = true;
                isConnecting.value = false;
                connectionStatus.value = "connected";

                // Join user room after connection
                _joinUserRoom();
            }
        );

        socket.onDisconnect((_)
            {
                debugPrint('6. ⚠️ SOCKET DISCONNECTED!');
                isConnected.value = false;
                connectionStatus.value = "disconnected";
            }
        );

        socket.onConnectError((error)
            {
                debugPrint('7. 💥 CONNECTION ERROR: $error');
                isConnected.value = false;
                isConnecting.value = false;
                connectionStatus.value = 'error';
            }
        );

        socket.onError((error)
            {
                debugPrint('8. 💥 SOCKET ERROR: $error');
            }
        );

        Future.delayed(const Duration(seconds: 10), ()
            {
                if (!isConnected.value && isConnecting.value)
                {
                    debugPrint('9. ⏰ CONNECTION TIMEOUT - Server not responding');
                    isConnecting.value = false;
                    connectionStatus.value = 'timeout';
                }
            }
        );
    }

    void _joinUserRoom()
    {
        final userId = _storageServices.getUserId();
        if (userId != null)
        {
            debugPrint('10. 🚪 Joining user room: $userId');
            socket.emit('join', {'userId': userId});
        }
    }

    // Public method to listen to events
    void listen(String event, Function(dynamic) handler)
    {
        if (isConnected.value)
        {
            socket.on(event, handler);
            debugPrint('👂 Listening for $event');
        }
        else
        {
            debugPrint('⚠️ Cannot listen to $event - Socket not connected');
        }
    }

    // Public method to emit events
    void send(String event, dynamic data)
    {
        if (isConnected.value)
        {
            socket.emit(event, data);
            debugPrint("📤 Emitted: $event | Data: $data");
        }
        else
        {
            debugPrint('⚠️ Cannot emit $event - Socket not connected');
        }
    }

    // Manual reconnect
    void reconnect()
    {
        debugPrint('🔄 Attempting to reconnect socket...');
        if (isConnecting.value)
        {
            _initializeSocket();
        }
    }

    // Disconnect manually
    void disconnect()
    {
        debugPrint('🛑 Disconnecting socket...');
        socket.disconnect();
        isConnected.value = false;
        connectionStatus.value = 'disconnected';
    }

    // Status check
    void printStatus()
    {
        debugPrint(
            '''
        SOCKET STATUS:
        - Connected: ${isConnected.value}
        - Connecting: ${isConnecting.value}
        - Status: ${connectionStatus.value}
        '''
        );

    }

    @override
    void onClose()
    {
        debugPrint('🛑 SocketService Closing...');
        disconnect();
        super.onClose();
    }
}
