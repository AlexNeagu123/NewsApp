import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:final_project/providers/providers.dart';
import 'package:final_project/widgets/shared/vertical_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FeedSidebar extends HookConsumerWidget {
  const FeedSidebar({super.key});

  Future<List<NewsProvider>> fetchSubscriptions(WidgetRef ref) async {
    final userSubscriptionsStorageService =
        ref.watch(userSubscribedFeedProvider.notifier);
    return userSubscriptionsStorageService.getAllSubscriptions();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      flex: 2,
      child: Container(
        color: Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalNavButton(
                onTap: () => {},
                buttonTitle: "All Posts",
                buttonIcon: const Icon(Icons.all_inbox)),
            VerticalNavButton(
                onTap: () => {},
                buttonTitle: "Unread",
                buttonIcon: const Icon(Icons.mark_as_unread)),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: const Divider()),
            FutureBuilder<List<NewsProvider>>(
              future: fetchSubscriptions(ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    strokeWidth: 5.0,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  final channels = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: channels.length,
                      itemBuilder: (context, index) {
                        return VerticalNavButton(
                          onTap: () => {},
                          buttonTitle: channels[index].providerName,
                          buttonIcon: const Icon(Icons.new_label_sharp),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
