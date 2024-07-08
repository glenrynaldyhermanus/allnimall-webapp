import 'package:allnimall_web/src/data/models/order_service.dart';

bool isServiceExistsInCart(List<OrderServiceModel> carts, String uid) {
  return carts.any((item) => item.serviceUid == uid);

}
