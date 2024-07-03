import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCategoryModel {
  String id;
  int sequence;
  String type;
  bool isActive;
  String name;
  String description;
  int groupSequence;

  ServiceCategoryModel({
    required this.id,
    required this.sequence,
    required this.type,
    required this.isActive,
    required this.name,
    required this.groupSequence,
    this.description = '',
  });

  factory ServiceCategoryModel.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ServiceCategoryModel(
      id: snapshot.id,
      sequence: data['sequence'],
      type: data['type'],
      isActive: data['is_active'],
      name: data['name'],
      description: data['description'] ?? '',
      groupSequence: data['group_sequence'],
    );
  }

  factory ServiceCategoryModel.fromJson(String id, Map<String, dynamic> json) {
    return ServiceCategoryModel(
      id: id,
      sequence: json['sequence'],
      type: json['type'],
      isActive: json['is_active'],
      name: json['name'],
      description: json['description'] ?? '',
      groupSequence: json['group_sequence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sequence': sequence,
      'type': type,
      'is_active': isActive,
      'name': name,
      'description': description,
      'group_sequence': groupSequence,
    };
  }
}
