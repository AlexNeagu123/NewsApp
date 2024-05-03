import 'package:final_project/firebase_options.dart';
import 'package:final_project/routes/app_router.dart';
import 'package:final_project/services/repositories/news_entities_repository.dart';
import 'package:final_project/services/repositories/news_providers_repository.dart';
import 'package:final_project/services/repositories/user_subscribed_feed_repository.dart';
import 'package:final_project/services/storage/storage_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await StorageBase.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(NewsProvidersRepository());
  Get.put(UserSubscribedFeedRepository());
  Get.put(NewsEntitiesRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      title: 'NewsApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: AppRouter.navigatorKey,
    ));
  }
}
