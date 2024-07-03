import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceAddOnModel {
  String? id;
  double fee;
  bool isActive;
  String name;
  int sequence;

  ServiceAddOnModel({
    this.id,
    required this.fee,
    required this.isActive,
    required this.name,
    required this.sequence,
  });

  factory ServiceAddOnModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ServiceAddOnModel(
      id: snapshot.id,
      fee: data['fee'],
      isActive: data['is_active'],
      name: data['name'],
      sequence: data['sequence'],
    );
  }

  factory ServiceAddOnModel.fromJsonWithId(String id, Map<String, dynamic> json) {
    return ServiceAddOnModel(
      id: id,
      fee: json['fee'],
      isActive: json['is_active'],
      name: json['name'],
      sequence: json['sequence'],
    );
  }

  factory ServiceAddOnModel.fromJson(Map<String, dynamic> json) {
    return ServiceAddOnModel(
      fee: json['fee'],
      isActive: json['is_active'],
      name: json['name'],
      sequence: json['sequence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fee': fee,
      'is_active': isActive,
      'name': name,
      'sequence': sequence,
    };
  }
}
