import 'package:final_project/models/feeds/news_entity/news_entity.dart';
import 'package:final_project/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedCard extends HookConsumerWidget {
  final NewsEntity feedItem;

  const FeedCard(this.feedItem, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(feedItem.title);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HtmlUnescape().convert(feedItem.title),
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              DateFormat('yyyy-MM-dd – kk:mm').format(feedItem.publishedOn),
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            Text(
              'By ${feedItem.author}',
              style:
                  const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8.0),
            Text(
              truncateHtmlString(feedItem.description, 400),
              style: const TextStyle(fontSize: 11.0),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () => launch(feedItem.link),
              child: const Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}
