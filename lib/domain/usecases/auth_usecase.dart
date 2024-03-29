import 'package:flutter_firebase_login/data/repositories/auth_repository_impl.dart';

class AuthUseCase {
  final AuthRepositoryImpl repository;

  AuthUseCase(this.repository);

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    return await repository.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> login(String email, String password) async {
    return await repository.login(email, password);
  }

  Future<void> signInWithGoogle() async {
    await repository.signInWithGoogle();
  }
}
