import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/repositories/order_repository.dart';

class GetCart extends UsecaseWithoutParams<List<OrderServiceModel>> {
  const GetCart(this._repo);

  final OrderRepository _repo;

  @override
  ResultFuture<List<OrderServiceModel>> call() => _repo.getCart();
}
