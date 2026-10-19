import '../../../auth/domain/entities/user_entity.dart';
import '../../../cart/domain/entities/order_entity.dart';
import '../../../home/domain/entities/meal_entity.dart';

abstract class ProfileRepository {
  Stream<UserEntity?> watchProfile(String uid);
  Future<void> updatePhoto(String uid, String photoBase64);
  Stream<List<MealEntity>> watchFavourites(String uid);
  Future<void> setFavourite(String uid, MealEntity meal,
      {required bool isFavourite});
  Future<void> placeOrder(String uid, OrderEntity order);
  Stream<List<OrderEntity>> watchOrders(String uid);
}
