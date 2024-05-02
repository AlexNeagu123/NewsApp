import 'dart:convert';

import 'package:final_project/services/storage/storage_base.dart';

class UserSubscriptionsStorageService {
  static const _subscriptionsKey = 'subscriptions';
  final _storage = StorageBase.instance;

  List<String> get subscriptions {
    final subscriptionsString =
        _storage.getCommonData<String>(_subscriptionsKey);
    if (subscriptionsString != null) {
      final subscriptions = List<String>.from(jsonDecode(subscriptionsString));
      return subscriptions;
    }
    return [];
  }

  void saveSubscriptions(List<String> subscriptions) {
    _storage.setCommonData<String>(
        _subscriptionsKey, jsonEncode(subscriptions));
  }

  void resetKeys() {
    _storage.removeCommonDataByKey(_subscriptionsKey);
  }

  void addSubscription(String newsProviderId) {
    if (isSubscribed(newsProviderId)) return;
    final subscriptions = this.subscriptions;
    subscriptions.add(newsProviderId);
    saveSubscriptions(subscriptions);
  }

  void removeSubscription(String newsProviderId) {
    final subscriptions = this.subscriptions;
    subscriptions.removeWhere((element) => element == newsProviderId);
    saveSubscriptions(subscriptions);
  }

  bool isSubscribed(String newsProviderId) {
    return subscriptions.any((element) => element == newsProviderId);
  }
}
