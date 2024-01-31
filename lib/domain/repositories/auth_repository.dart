// contracts
abstract class AuthRepository {
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  });

  Future<void> login(String email, String password);
}
