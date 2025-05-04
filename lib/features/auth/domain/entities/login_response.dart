
// import 'package:freezed_annotation/freezed_annotation.dart';
//
//
// part 'login_response.freezed.dart';
//
// @freezed
// class LoginResponse with _$LoginResponse {
//   const factory LoginResponse({
//     required String otp,
//   }) = _LoginResponse;
// }

class LoginEntity {
  final String otp;

  LoginEntity({required this.otp});

  @override
  String toString() {
    return 'LoginEntity{otp: $otp}';
  }
}