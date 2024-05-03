import 'package:final_project/providers/providers.dart';
import 'package:final_project/widgets/feed/feed_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FeedMain extends HookConsumerWidget {
  const FeedMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChannel = ref.watch(selectedChannelProvider);
    final feed = ref.watch(selectedChannelFeedProvider);

    return Flexible(
      flex: 3,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(selectedChannel.name,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold)),
            )),
        feed.when(
          data: (feedItems) => Expanded(
            child: ListView.builder(
              itemCount: feedItems.length,
              itemBuilder: (context, index) {
                return FeedCard(feedItems[index]);
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
      ]),
    );
  }
}
