import 'package:final_project/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsChannelCard extends HookConsumerWidget {
  final String title;
  final String id;
  final String description;
  final String mainUrl;

  const NewsChannelCard({
    super.key,
    required this.title,
    required this.description,
    required this.mainUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscribedFeeds = ref.watch(userSubscribedFeedProvider);
    final authState = ref.watch(authProvider);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.web),
                label: const Text('Visit Website'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () async => {
                  await launchURL(mainUrl),
                },
              ),
              Consumer(builder: (context, ref, child) {
                return authState.maybeWhen(
                    authenticated: (_) => IconButton(
                          icon: Icon(subscribedFeeds.contains(id)
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () {
                            String userId = ref
                                .watch(authProvider.notifier)
                                .currentUser
                                .userId;
                            subscribedFeeds.contains(id)
                                ? ref
                                    .read(userSubscribedFeedProvider.notifier)
                                    .removeSubscription(userId, id)
                                : ref
                                    .read(userSubscribedFeedProvider.notifier)
                                    .addSubscription(userId, id);
                          },
                        ),
                    unauthenticated: () => IconButton(
                          icon: const Icon(Icons.favorite_border),
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.grey[400],
                          ),
                          onPressed: () => {}, // Subscribe action
                        ),
                    orElse: () => const SizedBox.shrink());
              }),
            ],
          ),
        ],
      ),
    );
  }

  launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
