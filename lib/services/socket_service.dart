import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroment.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService();

  void connect() {
    // Dart client
    _socket = IO.io(Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconect() {
    _socket.disconnect();
  }
}
