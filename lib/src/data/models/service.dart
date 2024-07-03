import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String id;
  String categoryName;
  String categoryUid;
  String description;
  String type;
  double fee;
  bool isActive;
  String name;
  int sequence;
  List<ServiceAddOnModel>? addOns;

  ServiceModel({
    required this.id,
    required this.categoryName,
    required this.categoryUid,
    required this.description,
    required this.fee,
    required this.isActive,
    required this.name,
    required this.sequence,
    required this.type,
    this.addOns,
  });

  factory ServiceModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ServiceModel(
      id: snapshot.id,
      categoryName: data['category_name'],
      categoryUid: data['category_uid'].toString(),
      description: data['description'],
      fee: data['fee'],
      isActive: data['is_active'],
      name: data['name'],
      sequence: data['sequence'],
      type: data['type'],
    );
  }

  factory ServiceModel.fromJson(String id, Map<String, dynamic> json) {
    return ServiceModel(
      id: id,
      categoryName: json['category_name'],
      categoryUid: json['category_uid'].toString(),
      description: json['description'],
      fee: json['fee'],
      isActive: json['is_active'],
      name: json['name'],
      sequence: json['sequence'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_name': categoryName,
      'category_uid': categoryUid,
      'description': description,
      'fee': fee,
      'is_active': isActive,
      'name': name,
      'sequence': sequence,
      'type': type,
    };
  }
}
