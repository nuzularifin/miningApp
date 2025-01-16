import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/domain/repository/websocket_repository.dart';
import 'package:flutter_test_synapsys/presentation/bloc/websocket/websocket_event.dart';
import 'package:flutter_test_synapsys/presentation/bloc/websocket/websocket_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  final WebsocketRepository repository;

  late StreamSubscription _subscription;

  WebSocketBloc(this.repository) : super(WebSocketInitial()) {
    on<StartListening>((event, emit) {
      emit(WebSocketLoading());
      _subscription = repository.listenMessage().listen((message) {
        add(WebSocketInternalEvent(message: message));
      });
    });
    on<SendMessage>((event, emit) {});
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
