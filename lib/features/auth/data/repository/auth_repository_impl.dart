

import 'package:neww/features/auth/domain/entities/login/login_response.dart';

import '../../domain/entities/verify/verify_responce.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../model/profile/profile_model.dart';


  class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<LoginResponse> login(String phone) {
  return remoteDataSource.login(phone);
  }

  @override
  Future<VerifyResponse> verify(String phone, String code, String deviceId) {
    return remoteDataSource.verify(
      phone: phone,
      code: code,
      deviceId: deviceId,
    );
  }
  @override
  Future<ProfileModel> getProfile(String phone)  {
    return remoteDataSource.profile(
      phone: phone,
    );
   }
  }

