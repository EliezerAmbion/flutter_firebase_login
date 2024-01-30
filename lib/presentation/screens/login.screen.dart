import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/presentation/widgets/custom_form_button.widget.dart';
import 'package:flutter_firebase_login/presentation/widgets/custom_form_field.widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Form(
          child: Column(
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
              CustomFormFieldWidget(
                labelText: 'Enter your email',
                controller: loginController,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address!';
                  }
                  return null;
                },
                suffixIcon: Icons.email_outlined,
                horizontalPadding: 25,
                autoFill: AutofillHints.email,
              ),
              CustomFormFieldWidget(
                isObscureText: true,
                labelText: 'Enter your password',
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 7) {
                    return 'Password must be at least 7 chars long';
                  }
                  return null;
                },
                suffixIcon: Icons.lock_outline,
                horizontalPadding: 25,
                autoFill: AutofillHints.password,
              ),
              const SizedBox(height: 20),
              CustomFormButtonWidget(onPressed: () {}, text: 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
