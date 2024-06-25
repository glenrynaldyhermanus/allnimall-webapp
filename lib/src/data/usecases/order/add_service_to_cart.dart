import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:allnimall_web/src/data/repositories/order_repository.dart';

class AddServiceToCart
    extends UsecaseWithParams<List<OrderService>, AddServiceToCartParams> {
  const AddServiceToCart(this._repo);

  final OrderRepository _repo;

  @override
  ResultFuture<List<OrderService>> call(AddServiceToCartParams params) =>
      _repo.addServiceToCart(
          serviceUid: params.serviceUid,
          categoryName: params.categoryName,
          name: params.name,
          quantity: params.quantity,
          fee: params.fee,
          addOns: params.addOns);
}

class AddServiceToCartParams {
  const AddServiceToCartParams({
    required this.serviceUid,
    required this.categoryName,
    required this.fee,
    required this.name,
    required this.quantity,
    required this.addOns,
  });

  const AddServiceToCartParams.empty()
      : this(
      serviceUid: '',
      categoryName: '',
      fee: 0,
      name: '',
      quantity: 0,
      addOns: const []);

  final String serviceUid;
  final String categoryName;
  final double fee;
  final String name;
  final int quantity;
  final List<ServiceAddOn> addOns;
}