import 'package:allnimall_web/src/data/models/service_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PetCategoryModel {
  String id;
  int sequence;
  bool isActive;
  String name;
  double startFrom;
  List<ServiceCategoryModel>? services;

  PetCategoryModel(
      {required this.id,
      required this.sequence,
      required this.isActive,
      required this.name,
      this.services,
      required this.startFrom});

  factory PetCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PetCategoryModel(
        id: snapshot.id,
        sequence: snapshot['sequence'],
        isActive: snapshot['is_active'],
        name: snapshot['name'],
        startFrom: snapshot['start_from']);
  }

  factory PetCategoryModel.fromJson(String id, Map<String, dynamic> json) {
    return PetCategoryModel(
        id: id,
        sequence: json['sequence'],
        isActive: json['is_active'],
        name: json['name'],
        startFrom: json['start_from']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sequence': sequence,
      'is_active': isActive,
      'name': name,
      'start_from': startFrom
    };
  }
}
