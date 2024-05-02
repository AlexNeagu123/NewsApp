import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_provider.freezed.dart';
part 'news_provider.g.dart';

@freezed
class NewsProvider with _$NewsProvider {
  const factory NewsProvider(
      {required String providerId,
      required String description,
      required String category,
      required String? providerImageUrl,
      required String providerMainUrl,
      required String providerName,
      required String providerRssUrl}) = _NewsProvider;

  factory NewsProvider.fromJson(Map<String, dynamic> json) =>
      _$NewsProviderFromJson(json);
}
