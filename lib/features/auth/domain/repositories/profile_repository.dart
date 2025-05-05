


import '../entities/profile/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(String accessToken);
}