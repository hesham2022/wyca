// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketIOClientService {
//   static final String _baseUrl = 'http://localhost:3000'; // Replace with your server URL

//   IO.Socket _socket;

//   SocketIOClientService() {
//     _socket = IO.io(_baseUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });

//     // Register all events here
//     _socket.on('newMessage', (data) => EventManager.handleNewMessage(data));
//     _socket.on('userJoined', (data) => EventManager.handleUserJoined(data));
//     _socket.on('userLeft', (data) => EventManager.handleUserLeft(data));
//   }

//   void connect() {
//     _socket.connect();
//   }

//   void disconnect() {
//     _socket.disconnect();
//   }

//   void sendMessage(String message) {
//     // Emit a 'newMessage' event to the server with the given message
//     _socket.emit('newMessage', {'message': message});
//   }

//   void joinRoom(String roomId) {
//     // Emit a 'joinRoom' event to the server with the given room ID
//     _socket.emit('joinRoom', {'roomId': roomId});
//   }
// }

// class EventManager {
//   static void handleNewMessage(data) {
//     // Process new message event data here
//     StateManager.notifyNewMessage(data);
//   }

//   static void handleUserJoined(data) {
//     // Process user joined event data here
//     StateManager.notifyUserJoined(data);
//   }

//   static void handleUserLeft(data) {
//     // Process user left event data here
//     StateManager.notifyUserLeft(data);
//   }
// }

// class StateManager with ChangeNotifier {
//   bool _isConnected = false;

//   bool get isConnected => _isConnected;

//   void setConnected(bool value) {
//     _isConnected = value;
//     notifyListeners();
//   }

//   void notifyNewMessage(data) {
//     // Notify listeners of a new message
//     notifyListeners();
//   }

//   void notifyUserJoined(data) {
//     // Notify listeners of a user joined event
//     notifyListeners();
//   }

//   void notifyUserLeft(data) {
//     // Notify listeners of a user left event
//     notifyListeners();
//   }
// }
