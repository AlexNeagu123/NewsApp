import 'package:final_project/providers/providers.dart';
import 'package:final_project/routes/app_router.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/utilities/constants.dart';
import 'package:final_project/widgets/shared/navbar_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String title = "NewsApp";
  final PageType type;
  final double height = kToolbarHeight;

  const Navbar({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.cyan,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer(builder: (context, ref, child) {
            final authState = ref.watch(authProvider);
            return authState.maybeWhen(
              authenticated: (_) => NavBarButton(
                  text: "Feed",
                  icon: Icons.feed,
                  isUnderlined: type == PageType.feedPage,
                  onPressed: () {
                    AppRouter.pushNamed(Routes.feedScreenRoute);
                  },
                  color: Colors.black),
              unauthenticated: () => NavBarButton(
                  text: "Feed",
                  icon: Icons.feed,
                  isUnderlined: type == PageType.feedPage,
                  onPressed: () {
                    AppRouter.pushNamed(Routes.loginScreenRoute);
                  },
                  color: Colors.grey),
              orElse: () => const SizedBox.shrink(),
            );
          }),
          NavBarButton(
              text: "Channels",
              icon: Icons.new_label_sharp,
              isUnderlined: type == PageType.channelsPage,
              color: Colors.black,
              onPressed: () {
                AppRouter.pushNamed(Routes.channelScreenRoute);
              }),
          Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authProvider);
              return authState.maybeWhen(
                authenticated: (_) => NavBarButton(
                    text: "Logout",
                    icon: Icons.logout,
                    color: Colors.black,
                    onPressed: () {
                      ref.read(authProvider.notifier).logout();
                    }),
                unauthenticated: () => NavBarButton(
                    text: "Login",
                    icon: Icons.login,
                    color: Colors.black,
                    onPressed: () {
                      AppRouter.pushNamed(Routes.loginScreenRoute);
                    }),
                orElse: () => const SizedBox.shrink(),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
