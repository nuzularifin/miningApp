import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginAdminSuccess extends LoginState {}

class LoginTabletSuccess extends LoginState {
  final String name;
  final String roleName;

  LoginTabletSuccess({required this.name, required this.roleName});

  @override
  List<Object?> get props => [name, roleName];
}

class LoginAdminFailure extends LoginState {
  final String message;

  LoginAdminFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginTabletFailure extends LoginState {
  final String message;

  LoginTabletFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginAdminLoading extends LoginState {}

class LoginTabletLoading extends LoginState {}
