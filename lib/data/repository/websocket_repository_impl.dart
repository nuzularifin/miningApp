import 'package:flutter_test_synapsys/data/service/websocket_service.dart';
import 'package:flutter_test_synapsys/domain/model/websocket_message.dart';
import 'package:flutter_test_synapsys/domain/repository/websocket_repository.dart';

class WebsocketRepositoryImpl extends WebsocketRepository {
  final WebSocketService _service;

  WebsocketRepositoryImpl(this._service);

  @override
  void closeConnection() {
    _service.close();
  }

  @override
  Stream<WebsocketMessage> listenMessage() {
    return _service.message
        .map((message) => WebsocketMessage(message: message));
  }

  @override
  void sendMessage(String message) {
    _service.sendMessage(message);
  }
}
