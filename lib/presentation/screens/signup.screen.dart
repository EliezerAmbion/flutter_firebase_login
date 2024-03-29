import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/presentation/controller/auth.controller.dart';
import 'package:flutter_firebase_login/presentation/widgets/custom_form_button.widget.dart';
import 'package:flutter_firebase_login/presentation/widgets/custom_form_field.widget.dart';
import 'package:flutter_firebase_login/presentation/widgets/social_media_button.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<AuthController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.signupFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lets create an account
              Text(
                'Sign up',
                style: Theme.of(context).textTheme.headline3,
              ),

              const SizedBox(height: 10),

              Text(
                'Create your account',
                style: Theme.of(context).textTheme.headline5,
              ),

              const SizedBox(height: 20),

              // email field
              CustomFormFieldWidget(
                labelText: 'Email Address',
                controller: controller.emailController,
                suffixIcon: Icons.email_outlined,
                horizontalPadding: 25,
                autoFill: AutofillHints.email,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address!';
                  }
                  return null;
                },
              ),

              // password field
              CustomFormFieldWidget(
                labelText: 'Password',
                controller: controller.passwordController,
                isObscureText: true,
                suffixIcon: Icons.lock_outline,
                horizontalPadding: 25,
                autoFill: AutofillHints.password,
                validator: (value) {
                  const min = 7;

                  if (value!.isEmpty || value.length < min) {
                    return 'Password must be at least $min characters long';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              // button
              CustomFormButtonWidget(
                onPressed: () => controller.signUp(),
                text: 'SIGNUP',
              ),

              const SizedBox(height: 25),

              SocialMediaButton(
                  onTap: () => controller.signInWithGoogle(),
                  imagePath: 'assets/images/google.png'),

              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: 'Already a Member? ',
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(
                      text: 'Login Now!',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.isLogin.value = true;
                          controller.clearValues();
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
