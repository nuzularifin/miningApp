import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/domain/repository/device_manager_repository.dart';
import 'package:flutter_test_synapsys/presentation/bloc/device_manager/device_manager_event.dart';
import 'package:flutter_test_synapsys/presentation/bloc/device_manager/device_manager_state.dart';

class DeviceManagerBloc extends Bloc<DeviceManagerEvent, DeviceManagerState> {
  final DeviceManagerRepository repository;

  DeviceManagerBloc(this.repository) : super(DeviceManagerInitial()) {
    on<GetDeviceById>((event, emit) async {
      emit(DeviceManagerLoading());
      try {
        await repository.getDeviceById(event.deviceName);
        emit(DeviceManagerSuccess());
      } catch (e) {
        emit(DeviceManagerFailure(message: e.toString()));
      }
    });
  }
}
