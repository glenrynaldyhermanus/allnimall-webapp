import 'package:cloud_firestore/cloud_firestore.dart';

class GroomingOrder {
  double amount;
  DateTime? confirmedAt;
  DateTime createdAt;
  String customerAddress;
  String customerCity;
  GeoPoint customerLatLng;
  String customerName;
  String customerPhone;
  DocumentReference? customerUid;
  int? discount;
  String? endTime;
  String name;
  String notes;
  String orderNo;
  String paymentStatus;
  String petCategory;
  String preferredDay;
  String preferredTime;
  int quantity;
  String? rangerName;
  String? rangerPhone;
  String? rangerProfilePicture;
  DocumentReference? rangerUid;
  DateTime scheduledAt;
  String? service;
  String? startTime;
  String status;

  GroomingOrder({
    required this.amount,
    this.confirmedAt,
    required this.createdAt,
    required this.customerAddress,
    required this.customerCity,
    required this.customerLatLng,
    required this.customerName,
    required this.customerPhone,
    this.customerUid,
    this.discount,
    this.endTime,
    required this.name,
    required this.notes,
    required this.orderNo,
    required this.paymentStatus,
    required this.petCategory,
    required this.preferredDay,
    required this.preferredTime,
    required this.quantity,
    this.rangerName,
    this.rangerPhone,
    this.rangerProfilePicture,
    this.rangerUid,
    required this.scheduledAt,
    this.service,
    this.startTime,
    required this.status,
  });

  factory GroomingOrder.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return GroomingOrder(
      amount: data['amount'],
      confirmedAt: data['confirmed_at'],
      createdAt: data['created_at'],
      customerAddress: data['customer_address'],
      customerCity: data['customer_city'],
      customerLatLng: data['customer_latlng'],
      customerName: data['customer_name'],
      customerPhone: data['customer_phone'],
      customerUid: data['customer_uid'],
      discount: data['discount'],
      endTime: data['end_time'],
      name: data['name'],
      notes: data['notes'],
      orderNo: data['order_no'],
      paymentStatus: data['payment_status'],
      petCategory: data['pet_category'],
      preferredDay: data['preferred_day'],
      preferredTime: data['preferred_time'],
      quantity: data['quantity'],
      rangerName: data['ranger_name'],
      rangerPhone: data['ranger_phone'],
      rangerProfilePicture: data['ranger_profile_picture'],
      rangerUid: data['ranger_uid'],
      scheduledAt: data['scheduled_at'],
      service: data['service'],
      startTime: data['start_time'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'amount': amount,
      'confirmed_at': confirmedAt,
      'created_at': createdAt,
      'customer_address': customerAddress,
      'customer_city': customerCity,
      'customer_latlng': customerLatLng,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_uid': customerUid,
      'discount': discount,
      'end_time': endTime,
      'name': name,
      'notes': notes,
      'order_no': orderNo,
      'payment_status': paymentStatus,
      'pet_category': petCategory,
      'preferred_day': preferredDay,
      'preferred_time': preferredTime,
      'quantity': quantity,
      'ranger_name': rangerName,
      'ranger_phone': rangerPhone,
      'ranger_profile_picture': rangerProfilePicture,
      'ranger_uid': rangerUid,
      'scheduled_at': scheduledAt,
      'service': service,
      'start_time': startTime,
      'status': status,
    };
  }
}
