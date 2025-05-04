
import '../entities/login_response.dart';
import '../entities/verify/verify_responce.dart';


abstract class AuthRepository {
  Future<LoginEntity> login(String phone);

  Future<VerifyResponse> verifyPhone({
    required String phone,
    required String code,
    required String deviceId,
  });
}