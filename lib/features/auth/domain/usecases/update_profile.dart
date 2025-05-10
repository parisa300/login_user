
import '../entities/profile/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  Future<ProfileEntity> call(ProfileEntity profile) {
    return repository.updateProfile(profile);
  }
}