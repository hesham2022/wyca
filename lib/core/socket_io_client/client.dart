import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketioClientService {
  SocketioClientService(String url) {
    _socket = io.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    _socket.on('connect', (dynamic _) {
      setIsConnected = true;
    });
    registerHandlers(handlers);
  }

  bool isConnected = false;

  set setIsConnected(bool value) {
    isConnected = value;
    if (isConnected) {
      onConnected?.call();
    } else {
      onDisconnected?.call();
    }
  }

  bool get setIsConnected => isConnected;

  bool isConnecting = false;

  set setIsConnecting(bool value) {
    isConnecting = value;
    if (isConnecting) {
      onConnecting?.call();
    }
  }

  bool get setIsConnecting => isConnecting;

  bool isDisconnecting = false;

  set setIsDisconnecting(bool value) {
    isDisconnecting = value;
    if (isDisconnecting) {
      onDisconnecting?.call();
    }
  }

  bool get setIsDisconnecting => isDisconnecting;

  Function? onConnecting;

  Function? onConnected;

  Function? onDisconnecting;

  Function? onDisconnected;

  static const String _baseUrl =
      'http://localhost:3000'; // Replace with your server URL

  late io.Socket _socket;

  void connect() {
    setIsConnecting = true;
    _socket.connect();
  }

  void disconnect() {
    setIsDisconnecting = true;
    _socket.disconnect();
    setIsConnected = false;
  }

  void sendEvent<T>(String event, T data) {
    _socket.emit(event, data);
  }

  List<SocketEventHandler> handlers = [];
  // add new handler
  void addHandler(SocketEventHandler handler) {
    handlers.add(handler);
    _socket.on(handler.eventName, handler.eventHandler);
  }

  // New method for registering event handlers
  void registerHandlers(List<SocketEventHandler> handlers) {
    for (final handler in handlers) {
      _socket.on(handler.eventName, handler.eventHandler);
    }
  }
}

// A class to represent an event handler
class SocketEventHandler {
  SocketEventHandler({required this.eventName, required this.eventHandler});
  final String eventName;
  final Function(dynamic) eventHandler;
}
