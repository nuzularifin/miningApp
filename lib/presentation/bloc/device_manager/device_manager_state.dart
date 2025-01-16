import 'package:equatable/equatable.dart';

abstract class DeviceManagerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceManagerInitial extends DeviceManagerState {}

class DeviceManagerLoading extends DeviceManagerState {}

class DeviceManagerSuccess extends DeviceManagerState {}

class DeviceManagerFailure extends DeviceManagerState {
  final String message;

  DeviceManagerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
