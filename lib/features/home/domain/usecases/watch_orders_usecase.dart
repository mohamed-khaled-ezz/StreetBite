import '../../../cart/domain/entities/order_entity.dart';
import '../../../profile/domain/repositories/profile_repository.dart';

class WatchOrdersUseCase {
  WatchOrdersUseCase(this._repository);
  final ProfileRepository _repository;

  Stream<List<OrderEntity>> call(String uid) => _repository.watchOrders(uid);
}
