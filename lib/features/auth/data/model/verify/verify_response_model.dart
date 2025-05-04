//
import '../../../domain/entities/verify/verify_responce.dart';

class VerifyResponseModel extends VerifyResponse {
  VerifyResponseModel({
    required super.created,
    required super.accessToken,
    required super.refreshToken,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResponseModel(
      created: json['created'],
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
  }
}