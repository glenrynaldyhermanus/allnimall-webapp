import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceCategory {
  String id;
  int sequence;
  String type;
  bool isActive;
  String name;
  String description;
  int groupSequence;

  ServiceCategory({
    required this.id,
    required this.sequence,
    required this.type,
    required this.isActive,
    required this.name,
    required this.groupSequence,
    this.description = '',
  });

  factory ServiceCategory.fromSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ServiceCategory(
      id: snapshot.id,
      sequence: data['sequence'],
      type: data['type'],
      isActive: data['is_active'],
      name: data['name'],
      description: data['description'] ?? '',
      groupSequence: data['group_sequence'],
    );
  }

  factory ServiceCategory.fromJson(String id, Map<String, dynamic> json) {
    return ServiceCategory(
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
