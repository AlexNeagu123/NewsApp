import 'package:final_project/providers/providers.dart';
import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/routes/app_router.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/utilities/form_validator.dart';
import 'package:final_project/widgets/login/auth_title.dart';
import 'package:final_project/widgets/shared/auth_redirect_link.dart';
import 'package:final_project/widgets/shared/custom_text_field.dart';
import 'package:final_project/widgets/shared/spinner.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  RegisterScreen({super.key});

  void clearAndRedirect() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    AppRouter.pushNamed(Routes.feedScreenRoute);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    ref.listen<AuthState>(
      authProvider,
      (_, authState) => authState.maybeWhen(
        authenticated: (_) => clearAndRedirect(),
        failed: (reason) async => await FormValidator.showAlertDialog(
            "Registration Failed", reason, context),
        orElse: () {},
      ),
    );
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Form(
              key: formKey,
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
                        validator: (value) =>
                            FormValidator.confirmPasswordValidator(
                              _passwordController.text,
                              value,
                            )),
                    const AuthRedirectLink(
                        redirectLink: Routes.loginScreenRoute,
                        redirectText: "Already have an account? Log in"),
                    // Register button
                    const SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        child: RawMaterialButton(
                            fillColor: Colors.lightBlue,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                ref.read(authProvider.notifier).register(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }
                            },
                            child: Consumer(
                                builder: (context, ref, child) {
                                  final authState = ref.watch(authProvider);
                                  return authState.maybeWhen(
                                      authenticating: () => const Spinner(),
                                      orElse: () => child!);
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ))))
                  ]),
            ))));
  }
}
