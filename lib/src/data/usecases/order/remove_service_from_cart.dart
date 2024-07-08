import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/repositories/order_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remove_service_from_cart.g.dart';

class RemoveServiceFromCart extends UsecaseWithParams<List<OrderServiceModel>,
    RemoveServiceFromCartParams> {
  const RemoveServiceFromCart(this._repo);

  final OrderRepository _repo;

  @override
  ResultFuture<List<OrderServiceModel>> call(
          RemoveServiceFromCartParams params) =>
      _repo.removeServiceFromCart(serviceUid: params.serviceUid);
}

class RemoveServiceFromCartParams {
  const RemoveServiceFromCartParams({required this.serviceUid});

  const RemoveServiceFromCartParams.empty() : this(serviceUid: '');

  final String serviceUid;
}

@riverpod
RemoveServiceFromCart removeServiceFromCart(RemoveServiceFromCartRef ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return RemoveServiceFromCart(repo);
}
