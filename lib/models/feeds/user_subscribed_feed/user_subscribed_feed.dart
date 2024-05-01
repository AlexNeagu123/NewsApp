import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_subscribed_feed.freezed.dart';
part 'user_subscribed_feed.g.dart';

@freezed
class UserSubscribedFeed with _$UserSubscribedFeed {
  const factory UserSubscribedFeed(
      {required String subscribedProviderId,
      required String userId}) = _UserSubscribedFeed;

  factory UserSubscribedFeed.fromJson(Map<String, dynamic> json) =>
      _$UserSubscribedFeedFromJson(json);
}
