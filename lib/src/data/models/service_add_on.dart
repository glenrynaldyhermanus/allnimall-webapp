import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceAddOn {
  String? id;
  double fee;
  bool isActive;
  String name;
  int sequence;

  ServiceAddOn({
    this.id,
    required this.fee,
    required this.isActive,
    required this.name,
    required this.sequence,
  });

  factory ServiceAddOn.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ServiceAddOn(
      id: snapshot.id,
      fee: data['fee'],
      isActive: data['is_active'],
      name: data['name'],
      sequence: data['sequence'],
    );
  }

  factory ServiceAddOn.fromJsonWithId(String id, Map<String, dynamic> json) {
    return ServiceAddOn(
      id: id,
      fee: json['fee'],
      isActive: json['is_active'],
      name: json['name'],
      sequence: json['sequence'],
    );
  }

  factory ServiceAddOn.fromJson(Map<String, dynamic> json) {
    return ServiceAddOn(
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
