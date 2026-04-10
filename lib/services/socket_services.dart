import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled1/services/prefrense_services.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? _socket;
  IO.Socket? get socket => _socket;

  // Cache for listeners registered before socket is initialized
  final Map<String, List<Function(dynamic)>> _listenerCache = {};

  /// Connects to the socket server using the authorization token from preferences.
  void connect() {
    if (_socket != null && _socket!.connected) {
      log("Socket already connected.");
      return;
    }

    final String token = preferences.getString(SharedPreference.accessToken) ?? "";

    // Deriving socket URL from the API base URL
    // e.g., http://13.127.219.62/api/user -> http://13.127.219.62
    final String socketUrl = "http://13.127.219.62/notification";

    log("Connecting to socket: $socketUrl");

    _socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'Authorization': 'Bearer $token'},
    });

    _socket?.connect();

    _socket?.onConnect((_) {
      log('Socket Connection Status: Connected ✅');

      final userData = preferences.getUserData();
      if (userData?.data?.userId != null) {
        emit('joinroom', {'user_id': userData!.data!.userId});
        log('Emitted joinroom event for user: ${userData.data!.userId}');
      }
    });

    _socket?.onDisconnect((_) {
      log('Socket Connection Status: Disconnected ❌');
    });

    _socket?.onConnectError((data) {
      log('Socket Connection Status: Connect Error ⚠️ - $data');
    });

    _socket?.onError((data) {
      log('Socket Error: $data');
    });

    // Global listener to see all incoming events
    _socket?.onAny((event, data) {
      log('📥 Socket Event Received: [$event] - Data: $data');
    });

    // Re-apply cached listeners
    _listenerCache.forEach((event, handlers) {
      for (var handler in handlers) {
        _socket?.on(event, handler);
      }
    });
  }

  /// Disconnects the socket and clears the instance.
  void disconnect() {
    if (_socket != null) {
      _socket?.disconnect();
      _socket = null;
      log('Socket connection closed manually.');
    }
  }

  /// Emits an event to the server.
  void emit(String event, dynamic data) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit(event, data);
    } else {
      log("Socket not connected. Cannot emit event: $event");
    }
  }

  /// Listens for a specific event from the server.
  void on(String event, Function(dynamic) handler) {
    if (!_listenerCache.containsKey(event)) {
      _listenerCache[event] = [];
    }
    _listenerCache[event]!.add(handler);
    
    _socket?.on(event, handler);
  }

  /// Stops listening for a specific event.
  void off(String event) {
    _listenerCache.remove(event);
    _socket?.off(event);
  }

  /// Checks if the socket is currently connected.
  bool isConnected() {
    return _socket?.connected ?? false;
  }
}
