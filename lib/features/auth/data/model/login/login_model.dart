// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'login_model.freezed.dart';
// part 'login_model.g.dart';  // Add this for JSON serialization
//
// @freezed
// class LoginModel with _$LoginModel {
//   const factory LoginModel({
//     required Data data,
//   }) = _LoginModel;
//
//   factory LoginModel.fromJson(Map<String, dynamic> json) =>
//       _$LoginModelFromJson(json);
//
//   @override
//   // TODO: implement data
//   Data get data => throw UnimplementedError();
//
//   @override
//   Map<String, dynamic> toJson() {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }
// }
//
// @freezed
// class Data with _$Data {
//   const factory Data({
//     required String otp,
//   }) = _Data;
//
//   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
// }
import 'package:neww/features/auth/domain/entities/login_response.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required super.otp,

  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      otp: json['otp'],

    );
  }
}