import 'package:allnimall_web/src/data/models/order_service.dart';

double countCartsTotalAmount(List<OrderServiceModel> carts) {
  double total = 0;
  for (var cart in carts) {
    double fee = cart.fee;
    for (var addOn in cart.addOns) {
      fee += addOn.fee;
    }
    total += fee * cart.quantity;
  }

  return total;
}
