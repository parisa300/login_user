
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/usecases/verify_use_case.dart';
import 'verify_event.dart';
import 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final VerifyUseCase verifyCodeUseCase;

  VerifyBloc(this.verifyCodeUseCase) : super(VerifyInitial()) {
    on<VerifySubmitted>((event, emit) async {
      emit(VerifyLoading());
      try {
        final token = await verifyCodeUseCase(
          phone: event.phone,
          code: event.code,
          deviceId: event.deviceId,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token.accessToken);
        await prefs.setString('refresh_token', token.refreshToken);
        emit(VerifySuccess(token));
      } catch (e) {
        emit(VerifyFailure(e.toString()));
      }
    });
  }
}