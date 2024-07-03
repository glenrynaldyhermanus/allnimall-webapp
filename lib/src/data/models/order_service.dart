import 'dart:convert';

import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';

class OrderServiceModel {
  String? id;
  String serviceUid;
  String categoryName;
  double fee;
  String name;
  int quantity;
  List<ServiceAddOnModel> addOns;

  OrderServiceModel({
    this.id,
    required this.serviceUid,
    required this.categoryName,
    required this.fee,
    required this.name,
    required this.quantity,
    this.addOns = const [],
  });

  factory OrderServiceModel.fromJson(Map<String, dynamic> json) {
    return OrderServiceModel(
      serviceUid: json['service_uid'],
      categoryName: json['category_name'],
      fee: json['fee'],
      name: json['name'],
      quantity: json['quantity'],
      addOns: json['add_ons'] == null
          ? []
          : (json['add_ons'] as List).map((jsonAddon) {
              return ServiceAddOnModel.fromJsonWithId(jsonAddon['id'], jsonAddon);
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
