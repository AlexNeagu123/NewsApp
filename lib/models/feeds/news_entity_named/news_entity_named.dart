import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_entity_named.freezed.dart';
part 'news_entity_named.g.dart';

@freezed
class NewsEntityNamed with _$NewsEntityNamed {
  const factory NewsEntityNamed(
      {required String id,
      required String providerName,
      required String providerId,
      required String title,
      required String description,
      required String link,
      required String author,
      required DateTime publishedOn}) = _NewsEntityNamed;

  factory NewsEntityNamed.fromJson(Map<String, dynamic> json) =>
      _$NewsEntityNamedFromJson(json);
}
