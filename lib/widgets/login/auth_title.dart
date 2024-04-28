import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String appTitle;
  final String appWelcomeMessage;
  const AuthTitle(
      {super.key, required this.appTitle, required this.appWelcomeMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(appTitle,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold)),
          Text(appWelcomeMessage,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.normal)),
          const SizedBox(height: 22),
        ]);
  }
}
