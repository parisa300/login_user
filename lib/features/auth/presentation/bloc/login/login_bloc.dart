//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'login_event.dart';
// import 'login_state.dart';
// import '../../domain/usecases/login_usecase.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final LoginUseCase loginUseCase;
//
//   LoginBloc(this.loginUseCase) : super(const LoginState.initial()) {
//     on<LoginEvent>((event, emit) async {
//       await event.map(
//         sendPhone: (e) async {
//           emit(const LoginState.loading());
//           try {
//             final result = await loginUseCase(e.phone);
//             emit(LoginState.success(result.otp));
//           } catch (e) {
//             emit(LoginState.failure(e.toString()));
//           }
//         },
//       );
//     });
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        final otp = await repository.login(event.phone);
        emit(LoginSuccess(otp as String));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
