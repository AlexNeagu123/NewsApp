import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/feeds/user_subscribed_feed/user_subscribed_feed.dart';
import 'package:get/get.dart';

class UserSubscribedFeedRepository extends GetxController {
  static UserSubscribedFeedRepository get instance => Get.find();
  static const collection = "user_subscribed_feed";
  final _db = FirebaseFirestore.instance;

  Future<List<UserSubscribedFeed>> fetchAllByUserId(String userId) async {
    final snapshot = await _db
        .collection(collection)
        .where("userId", isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => UserSubscribedFeed.fromJson(doc.data()))
        .toList();
  }

  Future<void> add(UserSubscribedFeed userSubscribedFeed) async {
    await _db.collection(collection).add(userSubscribedFeed.toJson());
  }

  Future<void> remove(UserSubscribedFeed userSubscribedFeed) async {
    final snapshot = await _db
        .collection(collection)
        .where("userId", isEqualTo: userSubscribedFeed.userId)
        .where("subscribedProviderId",
            isEqualTo: userSubscribedFeed.subscribedProviderId)
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
