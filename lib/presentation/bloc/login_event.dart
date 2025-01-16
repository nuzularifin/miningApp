import 'package:flutter_test_synapsys/data/model/request/login_admin_request.dart';
import 'package:flutter_test_synapsys/data/model/request/login_tablet_request.dart';

abstract class LoginEvent {}

class LoginAdmin extends LoginEvent {
  final LoginAdminRequest request;

  LoginAdmin(this.request);
}

class LoginTablet extends LoginEvent {
  final LoginTabletRequest request;

  LoginTablet(this.request);
}
