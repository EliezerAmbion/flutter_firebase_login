import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/domain/usecases/auth_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthUseCase authUseCase;

  AuthController(this.authUseCase);

  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<void> login() async {
    try {
      final bool isValid = loginFormKey.currentState!.validate();
      if (!isValid) {
        Get.snackbar('Please try again.',
            'Either your email or your password is incorrect.');
        return;
      }

      await authUseCase.login(emailController.text, passwordController.text);
    } catch (e) {
      Get.snackbar('Please try again.', 'You cannot put empty values.');
      throw e.toString();
    }
  }

  Future<void> signUp() async {
    try {
      final bool isValid = signupFormKey.currentState!.validate();
      if (!isValid) return;

      await authUseCase.signUp(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
