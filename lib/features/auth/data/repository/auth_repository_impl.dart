

import '../../domain/entities/verify/verify_responce.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<VerifyResponse> verifyPhone({
    required String phone,
    required String code,
    required String deviceId,
  }) {
    return remoteDataSource.verifyPhone(
      phone: phone,
      code: code,
      deviceId: deviceId,
    );
  }

  // Method to login using the phone number and get OTP
  Future<String> login(String phone) async {
    return await remoteDataSource.login(phone);
  }

}