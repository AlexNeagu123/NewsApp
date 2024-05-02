import 'package:final_project/providers/providers.dart';
import 'package:final_project/utilities/constants.dart';
import 'package:final_project/widgets/channels/channel_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChannelsMain extends HookConsumerWidget {
  const ChannelsMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final newsChannels = ref.watch(selectedCategoryChannelsProvider);
    return Flexible(
      flex: 3,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(selectedCategory,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold)),
            )),
        newsChannels.when(
          data: (channels) => Expanded(
            child: ListView.builder(
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
                return NewsChannelCard(
                  title: channel.providerName,
                  id: channel.providerId,
                  mainUrl: channel.providerMainUrl,
                  description: channel.description == ""
                      ? "No description provided..."
                      : truncateWithEllipsis(channel.description, 100),
                );
              },
            ),
          ),
          loading: () => const CircularProgressIndicator(
            strokeWidth: 5.0,
          ),
          error: (error, stackTrace) => Text(
            'Error: $stackTrace',
            style: const TextStyle(color: Colors.red),
          ),
        )
      ]),
    );
  }
}
