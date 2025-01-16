import 'package:dio/dio.dart';
import 'package:flutter_test_synapsys/core/base_api_response.dart';
import 'package:flutter_test_synapsys/core/base_api_service.dart';

class DeviceManagerService extends BaseApiService {
  Future<BaseApiResponse> getDeviceById(String deviceName) async {
    try {
      final response = await dio.get('$baseUrl/equipments/devices/$deviceName');
      if (response.statusCode == 200) {
        final result = BaseApiResponse.fromJson(response.data, (data) => null);
        return result;
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    }
  }
}
