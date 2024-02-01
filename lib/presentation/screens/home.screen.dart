import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/presentation/controller/auth.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends GetView<AuthController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(Get.context!).size.width,
        height: MediaQuery.of(Get.context!).size.height,
        child: Obx(() {
          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // AREA
                    Text(
                      controller.weather.value?.areaName ?? '',
                      style: Theme.of(Get.context!).textTheme.headline2,
                    ),

                    const SizedBox(height: 20),

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
                          height:
                              MediaQuery.of(Get.context!).size.height * 0.20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'http://openweathermap.org/img/wn/${controller.weather.value?.weatherIcon}@4x.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          controller.weather.value?.weatherDescription ?? '',
                          style: Theme.of(Get.context!).textTheme.headline5,
                        ),
                      ],
                    )
                  ],
                );
        }),
      ),
    );
  }
}
