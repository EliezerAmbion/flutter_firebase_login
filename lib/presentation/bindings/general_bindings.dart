import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_login/data/repositories/auth_repository_impl.dart';
import 'package:flutter_firebase_login/domain/usecases/auth_usecase.dart';
import 'package:flutter_firebase_login/presentation/controller/auth.controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class GeneralBinding implements Bindings {
  @override
  void dependencies() {
    final firebaseAuth = FirebaseAuth.instance;
    final repository = AuthRepositoryImpl(firebaseAuth);
    final authUseCase = AuthUseCase(repository);

    // Get.put(firebaseAuth);
    // Get.put(repository);
    // Get.put(authUseCase);

    Get.put<AuthController>(AuthController(authUseCase));
  }
}
