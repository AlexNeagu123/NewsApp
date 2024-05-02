import "package:cloud_firestore/cloud_firestore.dart";
import "package:final_project/models/feeds/news_provider/news_provider.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";

class NewsProvidersRepository extends GetxController {
  static NewsProvidersRepository get instance => Get.find();
  static const collection = "news_providers";
  final _db = FirebaseFirestore.instance;

  Future<List<NewsProvider>> fetchAll() async {
    final snapshot = await _db.collection(collection).get();
    return snapshot.docs
        .map((doc) => NewsProvider.fromJson(doc.data()))
        .toList();
  }

  Future<List<NewsProvider>> fetchFilteredByCategory(String category) async {
    final snapshot = await _db
        .collection(collection)
        .where("category", isEqualTo: category)
        .get();

    return snapshot.docs
        .map((doc) => NewsProvider.fromJson(doc.data()))
        .toList();
  }

  Future<List<String>> fetchCategories() async {
    final snapshot = await _db.collection(collection).get();
    return snapshot.docs
        .map((doc) => doc.data()["category"] as String)
        .toSet()
        .toList()
      ..sort((a, b) => a.compareTo(b));
  }

  Future<List<NewsProvider>> fetchByProviderIds(
      List<String> providerIds) async {
    if (providerIds.isEmpty) return [];
    final snapshot = await _db
        .collection(collection)
        .where("providerId", whereIn: providerIds)
        .get();

    return snapshot.docs
        .map((doc) => NewsProvider.fromJson(doc.data()))
        .toList();
  }
}
