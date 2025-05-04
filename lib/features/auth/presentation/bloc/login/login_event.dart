
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
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  final String phone;

  LoginRequested(this.phone);

  @override
  List<Object?> get props => [phone];
}