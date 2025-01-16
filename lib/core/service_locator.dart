import 'package:dio/dio.dart';
import 'package:flutter_test_synapsys/data/repository/device_manager_repository_impl.dart';
import 'package:flutter_test_synapsys/data/repository/map_repository_impl.dart';
import 'package:flutter_test_synapsys/data/repository/mining_repository_impl.dart';
import 'package:flutter_test_synapsys/data/service/device_manager_service.dart';
import 'package:flutter_test_synapsys/data/service/mining_service.dart';
import 'package:flutter_test_synapsys/domain/repository/device_manager_repository.dart';
import 'package:flutter_test_synapsys/domain/repository/map_repository.dart';
import 'package:flutter_test_synapsys/domain/repository/mining_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<MiningService>(MiningService());
  sl.registerSingleton<DeviceManagerService>(DeviceManagerService());
  sl.registerSingleton<MiningRepository>(MiningRepositoryImpl(sl()));
  sl.registerSingleton<MapRepository>(MapRepositoryImpl());
  sl.registerSingleton<DeviceManagerRepository>(
      DeviceManagerRepositoryImpl(service: sl()));
}
