import 'package:equatable/equatable.dart';

abstract class VerifyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifySuccess extends VerifyState {
  final String accessToken;
  final String refreshToken;

  VerifySuccess({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

class VerifyFailure extends VerifyState {
  final String message;

  VerifyFailure(this.message);

  @override
  List<Object?> get props => [message];
}
