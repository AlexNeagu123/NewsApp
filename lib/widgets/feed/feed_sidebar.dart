import 'package:final_project/providers/providers.dart';
import 'package:final_project/widgets/shared/vertical_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FeedSidebar extends HookConsumerWidget {
  const FeedSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channels = ref.watch(subscribedChannelsFutureProvider);
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
            channels.when(
              data: (channels) => Expanded(
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
              ),
              loading: () => const CircularProgressIndicator(
                strokeWidth: 5.0,
              ),
              error: (error, stackTrace) => Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
