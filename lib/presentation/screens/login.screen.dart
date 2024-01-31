import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/presentation/controller/auth.controller.dart';
import 'package:flutter_firebase_login/presentation/widgets/custom_form_button.widget.dart';
import 'package:flutter_firebase_login/presentation/widgets/custom_form_field.widget.dart';
import 'package:flutter_firebase_login/presentation/widgets/social_media_button.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Form(
            key: controller.loginFormKey,
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back!',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Login to continue',
                        style: Theme.of(context).textTheme.headline5,
                      ),

                      const SizedBox(height: 30),

                      // email
                      CustomFormFieldWidget(
                        labelText: 'Enter your email',
                        controller: controller.emailController,
                        suffixIcon: Icons.email_outlined,
                        horizontalPadding: 25,
                        autoFill: AutofillHints.email,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            controller.isLoading.value = false;
                            return 'Please enter a valid email address!';
                          }
                          controller.isLoading.value = false;
                          return null;
                        },
                      ),

                      // password
                      CustomFormFieldWidget(
                        isObscureText: true,
                        labelText: 'Enter your password',
                        controller: controller.passwordController,
                        suffixIcon: Icons.lock_outline,
                        horizontalPadding: 25,
                        autoFill: AutofillHints.password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            controller.isLoading.value = false;
                            return 'Password cannot be empty.';
                          }
                          controller.isLoading.value = false;
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      CustomFormButtonWidget(
                        onPressed: () => controller.login(),
                        text: 'Login',
                      ),

                      const SizedBox(height: 20),

                      const SocialMediaButton(
                          imagePath: 'assets/images/google.png'),

                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                          text: TextSpan(
                            text: 'Not a Member? ',
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              TextSpan(
                                text: 'Register Now!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.isLogin.value = false;
                                    controller.isLoading.value = false;
                                    controller.emailController.text = '';
                                    controller.passwordController.text = '';
                                    controller.usernameController.text = '';
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
