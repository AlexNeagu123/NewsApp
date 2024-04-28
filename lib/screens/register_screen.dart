import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/utilities/form_validator.dart';
import 'package:final_project/widgets/login/auth_title.dart';
import 'package:final_project/widgets/shared/auth_redirect_link.dart';
import 'package:final_project/widgets/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const AuthTitle(
                      appTitle: "NewsApp",
                      appWelcomeMessage: "Sign in into the app"),
                  CustomTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter the email",
                      verticalPadding: 10.0,
                      prefix: const Icon(Icons.mail, color: Colors.black),
                      validator: FormValidator.emailValidator),
                  CustomTextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      verticalPadding: 10.0,
                      hintText: "Enter the password",
                      prefix: const Icon(Icons.lock, color: Colors.black),
                      validator: FormValidator.passwordValidator),
                  CustomTextField(
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      verticalPadding: 10.0,
                      hintText: "Confirm the password",
                      prefix: const Icon(Icons.password, color: Colors.black),
                      validator: FormValidator.passwordValidator),
                  const AuthRedirectLink(
                      redirectLink: Routes.loginScreenRoute,
                      redirectText: "Already have an account? Log in"),
                  // Register button
                  const SizedBox(height: 40),
                  SizedBox(
                      width: double.infinity,
                      child: RawMaterialButton(
                          fillColor: Colors.lightBlue,
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {},
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )))
                ]))));
  }
}
