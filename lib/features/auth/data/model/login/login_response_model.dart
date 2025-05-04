import '../../../domain/entities/login/login_response.dart';


class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({required super.otp});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(otp: json['data']['otp']);
  }
}