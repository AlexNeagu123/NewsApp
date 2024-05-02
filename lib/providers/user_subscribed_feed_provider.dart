import 'package:final_project/models/feeds/news_provider/news_provider.dart';
import 'package:final_project/models/feeds/user_subscribed_feed/user_subscribed_feed.dart';
import 'package:final_project/services/repositories/news_providers_repository.dart';
import 'package:final_project/services/repositories/user_subscribed_feed_repository.dart';
import 'package:final_project/services/storage/subscriptions/user_subscriptions_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserSubscribedFeedProvider extends StateNotifier<List<String>> {
  final UserSubscribedFeedRepository _userSubscribedFeedRepository;
  final NewsProvidersRepository _newsProvidersRepository;
  final UserSubscriptionsStorageService _userSubscriptionsStorageService;

  UserSubscribedFeedProvider(
      {required UserSubscribedFeedRepository userSubscribedFeedRepository,
      required UserSubscriptionsStorageService userSubscriptionsStorageService,
      required NewsProvidersRepository newsProvidersRepository})
      : _userSubscribedFeedRepository = userSubscribedFeedRepository,
        _newsProvidersRepository = newsProvidersRepository,
        _userSubscriptionsStorageService = userSubscriptionsStorageService,
        super(userSubscriptionsStorageService.subscriptions);

  Future<List<NewsProvider>> getAllSubscriptions() async {
    return await _newsProvidersRepository
        .fetchByProviderIds(_userSubscriptionsStorageService.subscriptions);
  }

  void clearState() {
    state = [];
  }

  void syncStateWithStorage() {
    state = _userSubscriptionsStorageService.subscriptions;
  }

  Future<void> addSubscription(String userId, String providerId) async {
    final userSubscribedFeed = UserSubscribedFeed(
      userId: userId,
      subscribedProviderId: providerId,
    );

    _userSubscriptionsStorageService.addSubscription(providerId);
    state = [...state, providerId];
    await _userSubscribedFeedRepository.add(userSubscribedFeed);
  }

  Future<void> removeSubscription(String userId, String providerId) async {
    final userSubscribedFeed = UserSubscribedFeed(
      userId: userId,
      subscribedProviderId: providerId,
    );

    _userSubscriptionsStorageService.removeSubscription(providerId);
    state = state.where((id) => id != providerId).toList();
    await _userSubscribedFeedRepository.remove(userSubscribedFeed);
  }
}
