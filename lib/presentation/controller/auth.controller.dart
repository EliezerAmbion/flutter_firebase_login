import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/config/keys.dart';
import 'package:flutter_firebase_login/domain/usecases/auth_usecase.dart';
import 'package:geolocator/geolocator.dart';
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
  final searchController = TextEditingController();

  Rxn<Weather?> weather = Rxn<Weather>(null);

  @override
  void onInit() async {
    super.onInit();
    await fetchWeather();
    clearValues();
  }

  void clearValues() {
    isLoading.value = false;
    emailController.text = '';
    passwordController.text = '';
  }

  Future<void> fetchWeather() async {
    try {
      isLoading.value = true;
      final loc = await _determinePosition();

      final WeatherFactory wf = WeatherFactory(OPEN_WEATHER_APIKEY);
      final cityWeather =
          await wf.currentWeatherByLocation(loc.latitude, loc.longitude);
      weather.value = cityWeather;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw Exception(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final loc = await Geolocator.getCurrentPosition();

    return loc;
  }

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
