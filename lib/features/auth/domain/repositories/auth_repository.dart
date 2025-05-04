
import '../entities/login/login_response.dart';
import '../entities/profile/profile_entity.dart';
import '../entities/verify/verify_responce.dart';


abstract class AuthRepository {
  Future<LoginResponse> login(String phone);

  Future<VerifyResponse> verify(String phone, String code, String deviceId);
  Future<ProfileEntity> getProfile();
}