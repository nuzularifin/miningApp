import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final double latitude;
  final double longitude;

  MapLoaded({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}

class MapError extends MapState {
  final String message;

  MapError({required this.message});

  @override
  List<Object?> get props => [message];
}
