import 'package:equatable/equatable.dart';
import 'package:flutter_test_synapsys/domain/model/websocket_message.dart';

abstract class WebSocketState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WebSocketInitial extends WebSocketState {}

class WebSocketLoading extends WebSocketState {}

class WebSocketReceived extends WebSocketState {
  final WebsocketMessage message;

  WebSocketReceived({required this.message});

  @override
  List<Object?> get props => [message];
}
