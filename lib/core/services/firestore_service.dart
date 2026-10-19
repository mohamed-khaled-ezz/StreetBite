import 'package:cloud_firestore/cloud_firestore.dart';

/// SINGLETON PATTERN: one shared Firestore wrapper for the whole app.
/// The private constructor plus the factory always return the same instance,
/// so every repository talks to Firestore through the same object.
class FirestoreService {
  FirestoreService._internal();

  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() => _instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _user(String uid) =>
      _db.collection('users').doc(uid);

  Future<void> saveUser(String uid, Map<String, dynamic> data) =>
      _user(uid).set(data, SetOptions(merge: true));

  Stream<Map<String, dynamic>?> watchUser(String uid) =>
      _user(uid).snapshots().map((snapshot) => snapshot.data());

  Future<void> setPhoto(String uid, String photoBase64) =>
      _user(uid).set({'photoBase64': photoBase64}, SetOptions(merge: true));

  /// Favourites live in the user document as a map keyed by meal id.
  Future<void> addFavourite(
    String uid,
    String mealId,
    Map<String, dynamic> mealJson,
  ) {
    return _user(uid).set(
      {
        'favourites': {mealId: mealJson},
      },
      SetOptions(merge: true),
    );
  }

  Future<void> removeFavourite(String uid, String mealId) {
    return _user(uid).update({'favourites.$mealId': FieldValue.delete()});
  }

  Future<void> saveOrder(
      String uid, String orderId, Map<String, dynamic> json) {
    return _user(uid).collection('orders').doc(orderId).set(json);
  }

  Stream<List<Map<String, dynamic>>> watchOrders(String uid) {
    return _user(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
