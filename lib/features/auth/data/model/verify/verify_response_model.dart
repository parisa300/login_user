//
import '../../../domain/entities/verify/verify_responce.dart';
class VerifyResponseModel extends VerifyResponse {
   VerifyResponseModel({
    required super.created,
    required super.accessToken,
    required super.refreshToken,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return VerifyResponseModel(
      created: data['created'],
      accessToken: data['access'],
      refreshToken: data['refresh'],
    );
  }
}