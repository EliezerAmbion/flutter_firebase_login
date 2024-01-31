import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/domain/usecases/auth_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthUseCase authUseCase;

  AuthController(this.authUseCase);

  final isLogin = RxBool(true);
  final isLoading = RxBool(false);
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<void> login() async {
    try {
      isLoading.value = true;

      final bool isValid = loginFormKey.currentState!.validate();
      if (!isValid) return;

      await authUseCase.login(emailController.text, passwordController.text);
      isLoading.value = false;
      return;
    } catch (e) {
      Get.snackbar('Please try again.', e.toString());
      isLoading.value = false;
      throw Exception(e.toString());
    }
  }

  Future<void> signUp() async {
    try {
      isLoading.value = true;

      final bool isValid = signupFormKey.currentState!.validate();
      if (!isValid) return;

      await authUseCase.signUp(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
      );
      isLoading.value = false;
      return;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading.value = false;
      throw Exception(e.toString());
    }
  }
}
