import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/domain/entities/order_entity.dart';
import '../../domain/usecases/watch_orders_usecase.dart';

class OrdersCubit extends Cubit<List<OrderEntity>> {
  OrdersCubit(this._watch) : super(const []);

  final WatchOrdersUseCase _watch;
  StreamSubscription<List<OrderEntity>>? _subscription;

  void watch(String uid) {
    _subscription?.cancel();
    _subscription = _watch(uid).listen(emit, onError: (_) {});
  }

  void stop() {
    _subscription?.cancel();
    emit(const []);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
