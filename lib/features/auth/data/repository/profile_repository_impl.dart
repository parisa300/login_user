

import '../../domain/entities/profile/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getProfile() {
    return remoteDataSource.getProfile();
  }
  
  @override
  Future<ProfileEntity> updateProfile(ProfileEntity profile) {
    return remoteDataSource.updateProfile(profile);
  }
}
