// contracts
abstract class AuthRepository {
  Future<void> signUp({
    required String email,
    required String password,
  });

  Future<void> login(String email, String password);

  Future<void> signInWithGoogle();
}
