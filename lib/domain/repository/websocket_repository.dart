import 'package:flutter_test_synapsys/domain/model/websocket_message.dart';

abstract class WebsocketRepository {
  Stream<WebsocketMessage> listenMessage();
  void sendMessage(String message);
  void closeConnection();
}
