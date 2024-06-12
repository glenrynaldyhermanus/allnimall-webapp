import 'package:allnimall_web/src/data/models/order_service.dart';

int countCartsTotalPet(List<OrderService> carts) {
  int total = 0;
  for (var cart in carts) {
    total += cart.quantity;
  }

  return total;
}
