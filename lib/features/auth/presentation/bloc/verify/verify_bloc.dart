import 'package:flutter_bloc/flutter_bloc.dart';
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
        emit(VerifySuccess(
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        ));
      } catch (e) {
        emit(VerifyFailure(e.toString()));
      }
    });
  }
}
