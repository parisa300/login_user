import '../entities/verify/verify_responce.dart';
import '../repositories/auth_repository.dart';

class VerifyUseCase {
  final AuthRepository repository;

  VerifyUseCase(this.repository);

  Future<VerifyResponse> call({
    required String phone,
    required String code,
    required String deviceId,
  }) {
    return repository.verifyPhone(
      phone: phone,
      code: code,
      deviceId: deviceId,
    );
  }
}