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

import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase useCase;

  LoginBloc(this.useCase) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        final otp = await useCase.execute(event.phone);
        yield LoginSuccess(otp);
      } catch (e) {
        yield LoginError('Failed to login: ${e.toString()}');
      }
    }
  }
}
