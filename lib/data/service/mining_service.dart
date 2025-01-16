import 'package:dio/dio.dart';
import 'package:flutter_test_synapsys/core/base_api_response.dart';
import 'package:flutter_test_synapsys/core/base_api_service.dart';
import 'package:flutter_test_synapsys/data/model/request/login_admin_request.dart';
import 'package:flutter_test_synapsys/data/model/request/login_tablet_request.dart';
import 'package:flutter_test_synapsys/data/model/response/user_data.dart';

class MiningService extends BaseApiService {
  Future<BaseApiResponse<UserData>> loginTablet(
    LoginTabletRequest request,
  ) async {
    try {
      final response =
          await dio.post('$baseUrl/login-tablet-unit', data: request.toJson());
      if (response.statusCode == 200) {
        final result = BaseApiResponse.fromJson(
          response.data,
          (data) => UserData.fromJson(data),
        );
        return result;
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }

  Future<BaseApiResponse> loginAdmin(
    LoginAdminRequest request,
  ) async {
    try {
      final response = await dio.post('$baseUrl/login',
          data: {'nik': request.nik, 'password': request.password});
      if (response.statusCode == 200) {
        final result =
            BaseApiResponse(message: 'Login successful', status: true);
        return result;
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }
}
