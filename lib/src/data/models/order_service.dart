import 'dart:convert';

import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';

class OrderService {
  String? id;
  String serviceUid;
  String categoryName;
  double fee;
  String name;
  int quantity;
  List<ServiceAddOn> addOns;

  OrderService({
    this.id,
    required this.serviceUid,
    required this.categoryName,
    required this.fee,
    required this.name,
    required this.quantity,
    this.addOns = const [],
  });

  factory OrderService.fromJson(Map<String, dynamic> json) {
    return OrderService(
      serviceUid: json['service_uid'],
      categoryName: json['category_name'],
      fee: json['fee'],
      name: json['name'],
      quantity: json['quantity'],
      addOns: json['add_ons'] == null
          ? []
          : (json['add_ons'] as List).map((jsonAddon) {
              return ServiceAddOn.fromJsonWithId(jsonAddon['id'], jsonAddon);
            }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_uid': serviceUid,
      'category_name': categoryName,
      'fee': fee,
      'name': name,
      'quantity': quantity,
      'add_ons': addOns.map((addOn) => addOn.toJson()).toList(),
    };
  }
}
