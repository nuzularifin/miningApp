import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/domain/repository/map_repository.dart';
import 'package:flutter_test_synapsys/presentation/bloc/map/map_event.dart';
import 'package:flutter_test_synapsys/presentation/bloc/map/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository repository;

  MapBloc(this.repository) : super(MapInitial()) {
    on<GetMapLocation>((event, emit) async {
      emit(MapLoading());
      // checking service enabled

      final result = await repository.getCurrentLocation();

      if (result == null) {
        emit(MapError(message: 'Cannot get current location'));
      } else {
        emit(MapLoaded(
          latitude: result.latitude,
          longitude: result.longitude,
        ));
      }
    });
  }
}
