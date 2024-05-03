import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/feeds/news_entity/news_entity.dart';
import 'package:get/get.dart';

class NewsEntitiesRepository extends GetxController {
  static NewsEntitiesRepository get instance => Get.find();
  static const collection = "news_entities";
  final _db = FirebaseFirestore.instance;

  Future<List<NewsEntity>> fetchAll() async {
    final snapshot = await _db.collection(collection).get();
    return snapshot.docs.map((doc) => NewsEntity.fromJson(doc.data())).toList();
  }

  Future<List<NewsEntity>> fetchByProviderId(String providerId) async {
    final snapshot = await _db
        .collection(collection)
        .where("providerId", isEqualTo: providerId)
        .get();

    return snapshot.docs.map((doc) => NewsEntity.fromJson(doc.data())).toList();
  }

  Future<List<NewsEntity>> fetchByProviderIds(List<String> providerIds) async {
    if (providerIds.isEmpty) return [];
    final snapshot = await _db
        .collection(collection)
        .where("providerId", whereIn: providerIds)
        .get();

    return snapshot.docs.map((doc) => NewsEntity.fromJson(doc.data())).toList();
  }

  Future<List<NewsEntity>> add(NewsEntity newsEntity) async {
    await _db.collection(collection).add(newsEntity.toJson());
    return fetchAll();
  }

  Future<List<NewsEntity>> findByLink(String link) async {
    final snapshot =
        await _db.collection(collection).where("link", isEqualTo: link).get();
    return snapshot.docs.map((doc) => NewsEntity.fromJson(doc.data())).toList();
  }
}
