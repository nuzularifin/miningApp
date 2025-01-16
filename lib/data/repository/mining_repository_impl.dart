import 'package:flutter_test_synapsys/core/base_api_response.dart';
import 'package:flutter_test_synapsys/data/model/request/login_admin_request.dart';
import 'package:flutter_test_synapsys/data/model/request/login_tablet_request.dart';
import 'package:flutter_test_synapsys/data/model/response/user_data.dart';
import 'package:flutter_test_synapsys/data/service/mining_service.dart';
import 'package:flutter_test_synapsys/domain/repository/mining_repository.dart';

class MiningRepositoryImpl extends MiningRepository {
  final MiningService _miningService;

  MiningRepositoryImpl(this._miningService);

  @override
  Future<BaseApiResponse> loginAdmin(LoginAdminRequest request) {
    return _miningService.loginAdmin(request);
  }

  @override
  Future<BaseApiResponse<UserData>> loginTablet(LoginTabletRequest request) {
    return _miningService.loginTablet(request);
  }

  @override
  Future<bool> isLoggedIn() {
    throw UnimplementedError();
  }

  @override
  Future<void> setLoggedIn(bool value) {
    throw UnimplementedError();
  }
}
