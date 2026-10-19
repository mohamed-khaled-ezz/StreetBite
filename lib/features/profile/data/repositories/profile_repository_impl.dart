import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/errors/failure_mapper.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../cart/data/models/order_model.dart';
import '../../../cart/domain/entities/order_entity.dart';
import '../../../home/data/models/meal_model.dart';
import '../../../home/domain/entities/meal_entity.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._firestore);

  final FirestoreService _firestore;

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseException catch (e) {
      throw FailureMapper.fromFirestore(e);
    }
  }

  @override
  Stream<UserEntity?> watchProfile(String uid) {
    return _firestore.watchUser(uid).map(
          (data) => data == null ? null : UserModel.fromJson(data),
        );
  }

  @override
  Future<void> updatePhoto(String uid, String photoBase64) =>
      _guard(() => _firestore.setPhoto(uid, photoBase64));

  @override
  Stream<List<MealEntity>> watchFavourites(String uid) {
    return _firestore.watchUser(uid).map((data) {
      final map = (data?['favourites'] as Map?) ?? {};
      return map.values
          .map((raw) =>
              MealModel.fromJson(Map<String, dynamic>.from(raw as Map)))
          .toList();
    });
  }

  @override
  Future<void> setFavourite(
    String uid,
    MealEntity meal, {
    required bool isFavourite,
  }) {
    return _guard(() {
      return isFavourite
          ? _firestore.addFavourite(
              uid, meal.id, MealModel.fromEntity(meal).toJson())
          : _firestore.removeFavourite(uid, meal.id);
    });
  }

  @override
  Future<void> placeOrder(String uid, OrderEntity order) {
    return _guard(() => _firestore.saveOrder(
          uid,
          order.id,
          OrderModel.fromEntity(order).toJson(),
        ));
  }

  @override
  Stream<List<OrderEntity>> watchOrders(String uid) {
    return _firestore
        .watchOrders(uid)
        .map((list) => list.map(OrderModel.fromJson).toList());
  }
}
