import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/repositories/order_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clear_cart.g.dart';

class ClearCart extends UsecaseWithoutParams<List<OrderServiceModel>> {
  const ClearCart(this._repo);

  final OrderRepository _repo;

  @override
  ResultFuture<List<OrderServiceModel>> call() => _repo.clearCart();
}

@riverpod
ClearCart clearCart(ClearCartRef ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return ClearCart(repo);
}
