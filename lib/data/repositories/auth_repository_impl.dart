import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_login/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }
}
