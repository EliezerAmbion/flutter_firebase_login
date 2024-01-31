import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/config/app_pages.dart';
import 'package:flutter_firebase_login/config/theme.dart';
import 'package:flutter_firebase_login/presentation/bindings/general_bindings.dart';
import 'package:flutter_firebase_login/presentation/screens/auth.screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: const AuthScreen(),
      initialBinding: GeneralBinding(),
      getPages: AppPages.pages,
    );
  }
}
