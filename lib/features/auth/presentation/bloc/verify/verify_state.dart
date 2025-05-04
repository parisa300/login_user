import '../../../domain/entities/verify/verify_responce.dart';

abstract class VerifyState {}
class VerifyInitial extends VerifyState {}
class VerifyLoading extends VerifyState {}
class VerifySuccess extends VerifyState {
  final VerifyResponse tokens;

  VerifySuccess(this.tokens);
}
class VerifyFailure extends VerifyState {
  final String error;

  VerifyFailure(this.error);
}