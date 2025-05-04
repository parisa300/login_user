
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'login_event.freezed.dart';
//
// @freezed
// class LoginEvent with _$LoginEvent {
//   const factory LoginEvent.sendPhone(String phone) = _SendPhone;
//
//
// }

abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String phone;

  LoginSubmitted(this.phone);
}