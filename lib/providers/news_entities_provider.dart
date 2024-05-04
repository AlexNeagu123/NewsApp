import 'package:final_project/models/feeds/news_entity_named/news_entity_named.dart';
import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:final_project/utilities/rss_parser.dart';

class NewsEntitiesProvider {
  NewsEntitiesProvider();

  Future<List<NewsEntityNamed>> getAllNewsByProvider(
      NewsProvider provider) async {
    final rssNews =
        await parseRSSFeedFromUrl(provider.providerRssUrl, provider.providerId);

    List<NewsEntityNamed> newsFeedNamed = rssNews
        .map((e) => NewsEntityNamed(
              id: e.id,
              providerName: provider.providerName,
              providerId: e.providerId,
              title: e.title,
              description: e.description,
              link: e.link,
              author: e.author,
              publishedOn: e.publishedOn,
            ))
        .toList();
    return newsFeedNamed;
  }

  Future<List<NewsEntityNamed>> getAllNewsByProviders(
      List<NewsProvider> providers) async {
    Map<String, String> providerIdToNewsProviderName = {};
    List<NewsEntityNamed> newsFeedNamed = [];

    for (final provider in providers) {
      providerIdToNewsProviderName[provider.providerId] = provider.providerName;
      final rssNews = await parseRSSFeedFromUrl(
          provider.providerRssUrl, provider.providerId);

      newsFeedNamed.addAll(rssNews
          .map((e) => NewsEntityNamed(
                id: e.id,
                providerName: provider.providerName,
                providerId: e.providerId,
                title: e.title,
                description: e.description,
                link: e.link,
                author: e.author,
                publishedOn: e.publishedOn,
              ))
          .toList());
    }

    return newsFeedNamed;
  }
}
