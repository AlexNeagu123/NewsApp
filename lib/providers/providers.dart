import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:final_project/providers/auth_provider.dart';
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

final selectedCategoryChannelsProvider =
    FutureProvider<List<NewsProvider>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final newsProviders = ref.watch(newsProvidersProvider);
  return newsProviders.getNewsProvidersByCategory(selectedCategory);
});
