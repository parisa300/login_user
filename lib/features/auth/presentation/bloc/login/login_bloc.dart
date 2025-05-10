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
import 'package:neww/features/auth/domain/usecases/login_usecase.dart';

import '../../../domain/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        String phone = event.phone;
          phone = '98${phone.substring(1)}'; // Convert phone to the full number

        // Call the login use case to get the OTP
        final response = await loginUseCase(phone); // Assuming LoginResponse contains OTP
        // Emit LoginSuccess with both OTP and the phone number
        emit(LoginSuccess(otp: response.otp, phone: phone));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });


  }
}
