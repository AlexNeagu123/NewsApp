import 'package:final_project/models/feeds/news_entity/news_entity.dart';
import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

Future<List<NewsEntity>> parseRSSFeedFromUrl(
    String rssUrl, String providerId) async {
  List<NewsEntity> newsList = [];
  var response = await http.get(Uri.parse(rssUrl));
  if (response.statusCode == 200) {
    xml.XmlDocument xmlDocument = xml.XmlDocument.parse(response.body);
    xml.XmlElement rssElement = xmlDocument.findElements('rss').first;
    xml.XmlElement channelElement = rssElement.findElements('channel').first;

    Iterable<xml.XmlElement> itemElements =
        channelElement.findElements('item').isEmpty
            ? channelElement.findElements('entry')
            : channelElement.findElements('item');

    for (xml.XmlElement itemElement in itemElements) {
      String title = itemElement.findElements('title').isEmpty
          ? "No title"
          : itemElement.findElements('title').first.innerText;
      String description = itemElement.findElements('description').isEmpty
          ? "No description"
          : itemElement.findElements('description').first.innerText;

      String pubDate = itemElement.findElements('pubDate').isEmpty
          ? "Unknown"
          : itemElement.findElements('pubDate').first.innerText;

      String link = itemElement.findElements('link').isEmpty
          ? ''
          : itemElement.findElements('link').first.innerText;

      String author = itemElement.findElements('dc:creator').isEmpty
          ? 'Unknown'
          : itemElement.findElements('dc:creator').first.innerText;

      NewsEntity newsEntity = NewsEntity(
          id: const Uuid().v4(),
          title: title,
          link: link,
          author: author,
          description: description,
          publishedOn:
              DateFormat('EEE, dd MMM yyyy HH:mm:ss +0000').parse(pubDate),
          providerId: providerId);

      newsList.add(newsEntity);
    }
  }

  return newsList;
}

Future<List<NewsEntity>> aggregateFeedFromMultipleProviders(
    List<NewsProvider> providers) async {
  List<NewsEntity> newsList = [];
  for (NewsProvider provider in providers) {
    newsList.addAll(await parseRSSFeedFromUrl(
        provider.providerRssUrl, provider.providerId));
  }

  newsList.sort((a, b) => b.publishedOn.compareTo(a.publishedOn));
  return newsList;
}
