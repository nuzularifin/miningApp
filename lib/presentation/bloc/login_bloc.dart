import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/domain/repository/mining_repository.dart';
import 'package:flutter_test_synapsys/presentation/bloc/login_event.dart';
import 'package:flutter_test_synapsys/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final MiningRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginAdmin>((event, emit) async {
      emit(LoginAdminLoading());
      try {
        await repository.loginAdmin(event.request);
        emit(LoginAdminSuccess());
      } catch (e) {
        emit(LoginAdminFailure(e.toString()));
      }
    });

    on<LoginTablet>((event, emit) async {
      emit(LoginTabletLoading());
      try {
        final times = getCodeBasedOnTime();
        event.request.shiftId = times;
        final result = await repository.loginTablet(event.request);

        emit(LoginTabletSuccess(
          name: result.data?.name ?? '',
          roleName: result.data?.roleName ?? '',
        ));
      } catch (e) {
        emit(LoginTabletFailure(e.toString()));
      }
    });
  }

  String getCodeBasedOnTime() {
    final now = DateTime.now();

    final currentHour = now.hour;
    final currentMinute = now.minute;

    if ((currentHour > 5 && currentHour < 17) ||
        (currentHour == 5 && currentMinute >= 0)) {
      return 'O48C-DS';
    } else {
      return 'O48C-NS';
    }
  }
}
