import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:final_project/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String initialRoute = Routes.loginScreenRoute;
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreenRoute:
        return MaterialPageRoute<dynamic>(
            builder: (_) => LoginScreen(),
            settings: const RouteSettings(name: Routes.loginScreenRoute));
      case Routes.registerScreenRoute:
        return MaterialPageRoute<dynamic>(
            builder: (_) => RegisterScreen(),
            settings: const RouteSettings(name: Routes.registerScreenRoute));
      case Routes.homeScreenRoute:
        return MaterialPageRoute<dynamic>(
            builder: (_) => const HomeScreen(),
            settings: const RouteSettings(name: Routes.homeScreenRoute));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Unknown Route'),
        ),
        body: const Center(
          child: Text('Unknown Route'),
        ),
      ),
    );
  }

  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState!.pop(result);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(initialRoute));
  }
}
