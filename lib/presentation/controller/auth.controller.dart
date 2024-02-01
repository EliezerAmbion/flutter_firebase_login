import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/config/keys.dart';
import 'package:flutter_firebase_login/domain/usecases/auth_usecase.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

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

  Rxn<Weather?> weather = Rxn<Weather>(null);

  @override
  void onInit() async {
    super.onInit();
    await fetchWeather();
  }

  Future<void> fetchWeather() async {
    isLoading.value = true;
    try {
      final WeatherFactory wf = WeatherFactory(OPEN_WEATHER_APIKEY);
      final cityWeather = await wf.currentWeatherByCityName('Pasay');
      weather.value = cityWeather;

      debugPrint('***(36): auth.controller***\n===> ${weather.value} <===');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw Exception(e.toString());
    }
  }

  Future<void> login() async {
    try {
      final bool isValid = loginFormKey.currentState!.validate();
      if (!isValid) return;

      authUseCase.login(emailController.text, passwordController.text);

      return;
    } catch (e) {
      Get.snackbar('Please try again.', e.toString());
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

  Future<void> signInWithGoogle() async {
    try {
      await authUseCase.signInWithGoogle();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
