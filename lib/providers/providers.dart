import 'package:final_project/models/feeds/news_entity_named/news_entity_named.dart';
import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:final_project/models/feeds/selected_channel/selected_channel.dart';
import 'package:final_project/providers/auth_provider.dart';
import 'package:final_project/providers/news_entities_provider.dart';
import 'package:final_project/providers/news_providers_provider.dart';
import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/providers/user_subscribed_feed_provider.dart';
import 'package:final_project/services/repositories/news_providers_repository.dart';
import 'package:final_project/services/repositories/user_subscribed_feed_repository.dart';
import 'package:final_project/services/storage/auth/auth_storage_service.dart';
import 'package:final_project/services/storage/subscriptions/user_subscriptions_storage_service.dart';
import 'package:final_project/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Firebase Auth Provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// Repositories
final newsProvidersRepositoryProvider =
    Provider<NewsProvidersRepository>((ref) {
  return NewsProvidersRepository.instance;
});

final userSubscribedFeedRepositoryProvider =
    Provider<UserSubscribedFeedRepository>((ref) {
  return UserSubscribedFeedRepository.instance;
});

// Storage Services
final authStorageProvider = Provider<AuthStorageService>((ref) {
  return AuthStorageService();
});

final userSubscriptionsStorageProvider =
    Provider<UserSubscriptionsStorageService>((ref) {
  return UserSubscriptionsStorageService();
});

// Auth
final authProvider =
    StateNotifierProvider<CustomAuthProvider, AuthState>((ref) {
  final authStorageService = ref.watch(authStorageProvider);
  final auth = ref.watch(firebaseAuthProvider);
  final userSubscriptionsStorageService =
      ref.watch(userSubscriptionsStorageProvider);
  final userSubscribedFeedRepository =
      ref.watch(userSubscribedFeedRepositoryProvider);

  return CustomAuthProvider(
      auth: auth,
      authStorageService: authStorageService,
      userSubscriptionsStorageService: userSubscriptionsStorageService,
      userSubscribedFeedRepository: userSubscribedFeedRepository,
      ref: ref);
});

// Channels
final newsProvidersProvider = Provider<NewsProvidersProvider>((ref) {
  final newsProvidersRepository = ref.watch(newsProvidersRepositoryProvider);
  return NewsProvidersProvider(
      newsProvidersRepository: newsProvidersRepository);
});

final newsEntitesProvider = Provider<NewsEntitiesProvider>((ref) {
  return NewsEntitiesProvider();
});

// Channel Categories
final newsCategoriesProvider = FutureProvider<List<String>>((ref) {
  final newsProviders = ref.watch(newsProvidersProvider);
  return newsProviders.getNewsCategories();
});

final userSubscribedFeedProvider =
    StateNotifierProvider<UserSubscribedFeedProvider, List<String>>((ref) {
  final userSubscribedFeedRepository =
      ref.watch(userSubscribedFeedRepositoryProvider);
  final newsProvidersRepository = ref.watch(newsProvidersRepositoryProvider);
  final userSubscriptionsStorageService =
      ref.watch(userSubscriptionsStorageProvider);
  return UserSubscribedFeedProvider(
    userSubscribedFeedRepository: userSubscribedFeedRepository,
    newsProvidersRepository: newsProvidersRepository,
    userSubscriptionsStorageService: userSubscriptionsStorageService,
  );
});

final selectedCategoryProvider = StateProvider<String>((ref) {
  return ChannelCategories.business;
});

final selectedChannelProvider = StateProvider<SelectedChannel>((ref) {
  return ChannelOptions.allFeed;
});

// Feed providers

final selectedCategoryChannelsProvider =
    FutureProvider<List<NewsProvider>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final newsProviders = ref.watch(newsProvidersProvider);
  return newsProviders.getNewsProvidersByCategory(selectedCategory);
});

final selectedChannelFeedProvider =
    FutureProvider<List<NewsEntityNamed>>((ref) async {
  final selectedChannel = ref.watch(selectedChannelProvider);
  final newsEntitiesProvider = ref.watch(newsEntitesProvider);
  final subscribedProviders = ref.watch(userSubscribedFeedProvider);
  final newsProvidersRepository = ref.watch(newsProvidersRepositoryProvider);

  if (selectedChannel == ChannelOptions.allFeed) {
    final subscribedProvidersList =
        await newsProvidersRepository.fetchByProviderIds(subscribedProviders);
    return newsEntitiesProvider.getAllNewsByProviders(subscribedProvidersList);
  }

  final subscribedProvider =
      await newsProvidersRepository.fetchByProviderId(selectedChannel.id);
  return newsEntitiesProvider.getAllNewsByProvider(subscribedProvider);
});

final selectedTimeFrameProvider = StateProvider<String>((ref) {
  return TimeFrameOptions.today;
});
