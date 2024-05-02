import 'package:final_project/routes/app_router.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/utilities/constants.dart';
import 'package:final_project/widgets/feed/feed_main.dart';
import 'package:final_project/widgets/feed/feed_sidebar.dart';
import 'package:final_project/widgets/shared/navbar.dart';
import 'package:final_project/widgets/shared/vertical_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/providers/providers.dart';

class FeedScreen extends HookConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(
      authProvider,
      (_, authState) => authState.maybeWhen(
        unauthenticated: () => AppRouter.pushNamed(Routes.channelScreenRoute),
        orElse: () {},
      ),
    );
    return const Scaffold(
      appBar: Navbar(type: PageType.feedPage),
      body: Row(
        children: [FeedSidebar(), FeedMain()],
      ),
    );
  }
}
