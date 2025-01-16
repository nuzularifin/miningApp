import 'package:flutter_test_synapsys/core/base_api_response.dart';

abstract class DeviceManagerRepository {
  Future<BaseApiResponse> getDeviceById(String deviceName);
}
