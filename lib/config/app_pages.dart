import 'package:flutter_firebase_login/presentation/bindings/general_bindings.dart';
import 'package:flutter_firebase_login/presentation/screens/home.screen.dart';
import 'package:flutter_firebase_login/presentation/screens/login.screen.dart';
import 'package:flutter_firebase_login/presentation/screens/signup.screen.dart';
import 'package:get/get.dart';
part 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: GeneralBinding(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => const SignUpScreen(),
    ),
  ];
}
