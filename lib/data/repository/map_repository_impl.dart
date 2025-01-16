import 'package:flutter_test_synapsys/domain/repository/map_repository.dart';
import 'package:geolocator/geolocator.dart';

class MapRepositoryImpl extends MapRepository {
  bool serviceEnabled = false;
  late LocationPermission permission;

  @override
  Future<Position?> getCurrentLocation() async {
    final permission = await _handleLocationPermission();
    if (!permission) return null;
    final position = await _getCurrentLocation();
    return position;
  }

  Future<bool> _handleLocationPermission() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<Position> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return position;
  }
}
