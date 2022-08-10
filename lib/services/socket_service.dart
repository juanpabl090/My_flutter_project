import 'package:flutter/material.dart';
import 'package:project_1/global/enviroment.dart';
import 'package:project_1/services/auth_services.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
 
  ServerStatus get serverStatus => _serverStatus;
  
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;
 
  void connect() async {
 
    final token = await AuthService.getToken();
    
    // Dart client
    _socket = IO.io( Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
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
 
  void disconnect() {
    _socket.disconnect();
  }
}

/*
  class SocketService with ChangeNotifier {
 
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
 
  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;
 
  void connect() async {
 
    final token = await AuthService.getToken();
    
    // Dart client
    this._socket = IO.io( Environment.socketUrl , {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });
 
    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
 
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
 
  }
 
 
  void disconnect() {
    this._socket.disconnect();
  }
 
}
*/