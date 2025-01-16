import 'package:flutter_test_synapsys/core/base_api_response.dart';
import 'package:flutter_test_synapsys/data/service/device_manager_service.dart';
import 'package:flutter_test_synapsys/domain/repository/device_manager_repository.dart';

class DeviceManagerRepositoryImpl extends DeviceManagerRepository {
  final DeviceManagerService service;

  DeviceManagerRepositoryImpl({required this.service});

  @override
  Future<BaseApiResponse> getDeviceById(String deviceName) {
    return service.getDeviceById(deviceName);
  }
}
