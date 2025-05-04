import 'package:equatable/equatable.dart';

abstract class VerifyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyRequested extends VerifyEvent {
  final String phone;
  final String code;
  final String deviceId;

  VerifyRequested({
    required this.phone,
    required this.code,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [phone, code, deviceId];
}
