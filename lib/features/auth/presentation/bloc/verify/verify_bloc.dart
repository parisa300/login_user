import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'verify_event.dart';
import 'verify_state.dart';


class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final AuthRepository repository;

  VerifyBloc(this.repository) : super(VerifyInitial()) {
    on<VerifyRequested>((event, emit) async {
      emit(VerifyLoading());
      try {
        final tokens = await repository.verify(
          event.phone,
          event.code,
          event.deviceId,
        );


        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', tokens.accessToken);
        await prefs.setString('refresh_token', tokens.refreshToken);

        emit(VerifySuccess(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        ));
        await prefs.setString('phone', event.phone);
        await prefs.setString('code', event.code);
        await prefs.setString('device_id', event.deviceId);
      } catch (e) {
        emit(VerifyFailure(e.toString()));
      }
    });
  }
}
