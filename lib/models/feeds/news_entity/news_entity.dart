import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_entity.freezed.dart';
part 'news_entity.g.dart';

@freezed
class NewsEntity with _$NewsEntity {
  const factory NewsEntity(
      {required String id,
      required String providerId,
      required String title,
      required String description,
      required String link,
      required String author,
      required DateTime publishedOn}) = _NewsEntity;

  factory NewsEntity.fromJson(Map<String, dynamic> json) =>
      _$NewsEntityFromJson(json);
}
