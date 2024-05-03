import 'package:final_project/models/feeds/news_entity/news_entity.dart';
import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:final_project/services/repositories/news_entities_repository.dart';
import 'package:final_project/utilities/rss_parser.dart';
import 'package:flutter/foundation.dart';

class NewsEntitiesProvider {
  final NewsEntitiesRepository _newsEntitiesRepository;

  NewsEntitiesProvider({required NewsEntitiesRepository newsEntitiesRepository})
      : _newsEntitiesRepository = newsEntitiesRepository;

  Future<List<NewsEntity>> getAllNewsByProvider(NewsProvider provider) async {
    final rssNews =
        await parseRSSFeedFromUrl(provider.providerRssUrl, provider.providerId);

    debugPrint(rssNews.toString());
    for (final news in rssNews) {
      final newsFoundInDb = await _newsEntitiesRepository
          .findByProviderIdAndDateAndTitleAndDescription(
              news.providerId, news.publishedOn, news.title, news.description);

      if (newsFoundInDb.isEmpty) {
        await _newsEntitiesRepository.add(news);
      }
    }

    return await _newsEntitiesRepository.fetchByProviderId(provider.providerId);
  }

  Future<List<NewsEntity>> getAllNewsByProviders(
      List<NewsProvider> providers) async {
    final List<String> providerIds =
        providers.map((e) => e.providerId).toList();
    for (final provider in providers) {
      final rssNews = await parseRSSFeedFromUrl(
          provider.providerRssUrl, provider.providerId);
      debugPrint(rssNews.toString());

      for (final news in rssNews) {
        final newsFoundInDb = await _newsEntitiesRepository
            .findByProviderIdAndDateAndTitleAndDescription(news.providerId,
                news.publishedOn, news.title, news.description);

        if (newsFoundInDb.isEmpty) {
          await _newsEntitiesRepository.add(news);
        }
      }
    }
    return await _newsEntitiesRepository.fetchByProviderIds(providerIds);
  }
}
