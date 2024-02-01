import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/presentation/controller/auth.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends GetView<AuthController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.fetchWeather(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather Report',
            style: Theme.of(Get.context!).textTheme.headline3?.copyWith(
                  color: Colors.white,
                ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                controller.clearValues();
              },
              child: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Obx(() {
          return controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    width: MediaQuery.of(Get.context!).size.width,
                    height: MediaQuery.of(Get.context!).size.height * 0.80,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // AREA
                        Text(
                          controller.weather.value?.areaName ?? '',
                          style: Theme.of(Get.context!).textTheme.headline2,
                        ),

                        const SizedBox(height: 50),

                        // TIME
                        Text(
                          DateFormat('h:mm a').format(DateTime.now()),
                          style: Theme.of(Get.context!).textTheme.headline1,
                        ),

                        // Date
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat.yMMMd().format(DateTime.now()),
                              style: Theme.of(Get.context!).textTheme.headline4,
                            ),
                          ],
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(Get.context!).size.height *
                                  0.15,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'http://openweathermap.org/img/wn/${controller.weather.value?.weatherIcon}@4x.png',
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              controller.weather.value?.weatherDescription ??
                                  '',
                              style: Theme.of(Get.context!).textTheme.headline5,
                            ),

                            const SizedBox(height: 30),

                            // Degrees
                            Text(
                              '${controller.weather.value?.temperature?.celsius?.toStringAsFixed(0)}°C',
                              style: Theme.of(Get.context!).textTheme.headline2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
