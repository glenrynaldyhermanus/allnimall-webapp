import 'package:allnimall_web/src/data/models/service_add_on.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddServiceToCartEvent extends CartEvent {
  const AddServiceToCartEvent({
    required this.serviceUid,
    required this.categoryName,
    required this.fee,
    required this.name,
    required this.quantity,
    required this.addOns,
  });

  final String serviceUid;
  final String categoryName;
  final double fee;
  final String name;
  final int quantity;
  final List<ServiceAddOn> addOns;
}

class ClearCartEvent extends CartEvent {}

class CheckCartEvent extends CartEvent {}
