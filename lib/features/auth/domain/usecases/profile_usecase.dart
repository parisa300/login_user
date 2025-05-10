
import '../entities/profile/profile_entity.dart';
import '../repositories/profile_repository.dart';


class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<ProfileEntity> call() {
    return repository.getProfile();
  }
}