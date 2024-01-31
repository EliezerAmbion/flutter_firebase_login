import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showLoading(BuildContext context) async {
  await Get.dialog(
    Center(
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
    ),
  );
}
