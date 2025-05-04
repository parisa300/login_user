abstract class VerifyEvent {}


class VerifySubmitted extends VerifyEvent {
  final String phone;
  final String code;
  final String deviceId;

  VerifySubmitted(this.phone, this.code, this.deviceId);
}