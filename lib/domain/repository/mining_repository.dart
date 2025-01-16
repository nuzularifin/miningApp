import 'package:flutter_test_synapsys/core/base_api_response.dart';
import 'package:flutter_test_synapsys/data/model/request/login_admin_request.dart';
import 'package:flutter_test_synapsys/data/model/request/login_tablet_request.dart';
import 'package:flutter_test_synapsys/data/model/response/user_data.dart';

abstract class MiningRepository {
  Future<BaseApiResponse> loginAdmin(
    LoginAdminRequest request,
  );

  Future<BaseApiResponse<UserData>> loginTablet(
    LoginTabletRequest request,
  );

  Future<bool> isLoggedIn();
  Future<void> setLoggedIn(bool value);
}
