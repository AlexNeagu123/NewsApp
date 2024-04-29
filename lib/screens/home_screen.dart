import 'package:final_project/widgets/login/auth_title.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthTitle(
              appTitle: "NewsApp",
              appWelcomeMessage: "Welcome to the app",
            ),
            // News feed
            SizedBox(height: 40),
            // Logout button
            SizedBox(height: 40),
          ],
        ),
      ),
    ));
  }
}
