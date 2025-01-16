abstract class DeviceManagerEvent {}

class GetDeviceById extends DeviceManagerEvent {
  final String deviceName;

  GetDeviceById({required this.deviceName});
}
