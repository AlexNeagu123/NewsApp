import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/screens/channels_screen.dart';
import 'package:final_project/screens/feed_screen.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:final_project/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String initialRoute = Routes.feedScreenRoute;
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
      case Routes.feedScreenRoute:
        return MaterialPageRoute<dynamic>(
            builder: (_) => const FeedScreen(),
            settings: const RouteSettings(name: Routes.feedScreenRoute));
      case Routes.channelScreenRoute:
        return MaterialPageRoute<dynamic>(
            builder: (_) => const ChannelsScreen(),
            settings: const RouteSettings(name: Routes.channelScreenRoute));
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
