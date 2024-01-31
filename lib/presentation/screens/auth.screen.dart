import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/presentation/controller/auth.controller.dart';
import 'package:flutter_firebase_login/presentation/screens/home.screen.dart';
import 'package:flutter_firebase_login/presentation/screens/login.screen.dart';
import 'package:flutter_firebase_login/presentation/screens/signup.screen.dart';
import 'package:get/get.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return Obx(
              () => controller.isLogin.value
                  ? const LoginScreen()
                  : const SignUpScreen(),
            );
          }
        },
      ),
    );
  }
}
