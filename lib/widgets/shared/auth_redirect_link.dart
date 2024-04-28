import 'package:final_project/routes/app_router.dart';
import 'package:flutter/material.dart';

class AuthRedirectLink extends StatelessWidget {
  final String redirectLink;
  final String redirectText;
  const AuthRedirectLink(
      {super.key, required this.redirectLink, required this.redirectText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          AppRouter.pushNamed(redirectLink);
        },
        child: Text(redirectText, style: const TextStyle(color: Colors.blue)));
  }
}
