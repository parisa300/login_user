
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