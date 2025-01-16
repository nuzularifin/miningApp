import 'package:equatable/equatable.dart';
import 'package:flutter_test_synapsys/domain/model/websocket_message.dart';

abstract class WebSocketEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartListening extends WebSocketEvent {}

class SendMessage extends WebSocketEvent {}

class WebSocketInternalEvent extends WebSocketEvent {
  final WebsocketMessage message;

  WebSocketInternalEvent({required this.message});

  @override
  List<Object?> get props => [message];
}
