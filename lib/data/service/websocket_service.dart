import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final WebSocketChannel _channel;

  WebSocketService(String url)
      : _channel = WebSocketChannel.connect(Uri.parse(url));

  Stream get message => _channel.stream;

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void close() {
    _channel.sink.close();
  }
}
