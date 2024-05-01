import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:final_project/services/repositories/news_providers_repository.dart';

class NewsProvidersProvider {
  final NewsProvidersRepository _newsProvidersRepository;
  NewsProvidersProvider(
      {required NewsProvidersRepository newsProvidersRepository})
      : _newsProvidersRepository = newsProvidersRepository,
        super();

  Future<List<NewsProvider>> getAllNewsProviders() async {
    return await _newsProvidersRepository.fetchAll();
  }

  Future<List<NewsProvider>> getNewsProvidersByCategory(String category) async {
    return await _newsProvidersRepository.fetchFilteredByCategory(category);
  }

  Future<List<String>> getNewsCategories() async {
    return await _newsProvidersRepository.fetchCategories();
  }
}
