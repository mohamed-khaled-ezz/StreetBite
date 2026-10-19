import '../../../profile/domain/repositories/profile_repository.dart';
import '../entities/order_entity.dart';

class PlaceOrderUseCase {
  PlaceOrderUseCase(this._repository);
  final ProfileRepository _repository;

  Future<void> call(String uid, OrderEntity order) =>
      _repository.placeOrder(uid, order);
}
