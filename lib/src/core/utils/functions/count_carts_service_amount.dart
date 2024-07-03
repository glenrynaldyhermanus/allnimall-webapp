import 'package:allnimall_web/src/data/models/order_service.dart';

double countCartsServiceAmount(OrderServiceModel cart) {
  double total = 0;
  double fee = cart.fee;
  for (var addOn in cart.addOns) {
    fee += addOn.fee;
  }
  total += fee * cart.quantity;

  return total;
}
