import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'email': email,
        'groups': [],
        'groupRequests': [],
        'uid': authResult.user!.uid,
        'displayName': username,
        'emailVerified': false,
        'photoUrl': '',
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('This password is too weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('This account already exists');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserCredential> login(String email, String password) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
