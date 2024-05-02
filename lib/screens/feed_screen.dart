import 'package:final_project/routes/app_router.dart';
import 'package:final_project/routes/app_routes.dart';
import 'package:final_project/utilities/constants.dart';
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
    List<String> subscribedChannels = [
      'Channel 1',
      'Channel 2',
      'Channel 3',
      'Channel 4',
    ];
    return Scaffold(
      appBar: const Navbar(type: PageType.feedPage),
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalNavButton(
                      buttonTitle: "All Posts",
                      buttonIcon: Icon(Icons.all_inbox)),
                  const VerticalNavButton(
                      buttonTitle: "Unread",
                      buttonIcon: Icon(Icons.mark_as_unread)),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 0),
                      child: const Divider()),
                  Expanded(
                    child: ListView.builder(
                      itemCount: subscribedChannels.length,
                      itemBuilder: (context, index) {
                        return VerticalNavButton(
                          buttonTitle: subscribedChannels[index],
                          buttonIcon: const Icon(Icons.new_label_sharp),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Flexible(
            flex: 3,
            child: Center(
              child: Text('Main Content Area'),
            ),
          ),
        ],
      ),
    );
  }
}
