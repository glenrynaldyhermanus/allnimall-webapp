import 'package:allnimall_web/src/data/models/order_service.dart';

String generateOrderName(List<OrderService> carts) {
  String orderName = "";

  for (var cart in carts) {
    if (orderName.isNotEmpty) {
      orderName += ", ";
    }
    orderName += "${cart.name} x ${cart.quantity} ${cart.categoryName}";
  }

  return orderName;
}
