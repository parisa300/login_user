
import '../../data/repository/auth_repository_impl.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepositoryImpl repository;

  // Constructor that accepts AuthRepositoryImpl
  LoginUseCase(this.repository);

  // Method to execute login
  Future<String> execute(String phone) async {
    return await repository.login(phone);
  }
}