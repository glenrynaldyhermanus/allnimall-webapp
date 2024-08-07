import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/functions/count_carts_total_amount.dart';
import 'package:allnimall_web/src/core/utils/functions/count_carts_total_pet.dart';
import 'package:allnimall_web/src/core/utils/functions/generate_order_name.dart';
import 'package:allnimall_web/src/core/utils/functions/generate_order_no.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/objects/grooming_schedule.dart';
import 'package:allnimall_web/src/data/objects/personal_information.dart';
import 'package:allnimall_web/src/data/objects/personal_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_grooming_order.g.dart';

class CreateGroomingOrder
    extends UsecaseWithParams<List<OrderModel>, CreateGroomingOrderParams> {
  const CreateGroomingOrder(this.firestore);

  final FirebaseFirestore firestore;

  @override
  ResultFuture<List<OrderModel>> call(CreateGroomingOrderParams params) async {
    try {
      final order = OrderModel(
          amount: countCartsTotalAmount(params.carts),
          createdAt: DateTime.now(),
          customerAddress: params.personalInfo.location.address,
          customerCity: params.personalInfo.location.city,
          customerLatLng: GeoPoint(params.personalInfo.location.latLng.latitude,
              params.personalInfo.location.latLng.longitude),
          customerName: params.personalInfo.name,
          customerPhone: "+62${params.personalInfo.phone.replaceAll("-", "")}",
          name: generateOrderName(params.carts),
          notes: '',
          orderNo: generateOrderNo(),
          paymentStatus: "Unpaid",
          petCategory: 'Kucing',
          preferredDay: "Weekday",
          preferredTime: "Pagi",
          quantity: countCartsTotalPet(params.carts),
          scheduledAt: params.groomingSchedule.date,
          service: 'Grooming',
          status: 'New');

      await firestore.collection("order_groomings").add(order.toSnapshot());
      await firestore.collection("orders").add(order.toSnapshot());
      return Right([order]);
    } catch (e) {
      logger.e("createGroomingOrder => $e");
      return Left(CacheFailure(
          message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
          statusCode: 500));
    }
  }
}

class CreateGroomingOrderParams {
  const CreateGroomingOrderParams({
    required this.personalInfo,
    required this.carts,
    required this.groomingSchedule,
  });

  CreateGroomingOrderParams.empty()
      : this(
            personalInfo: PersonalInformation(
                name: '',
                phone: '',
                location: PersonalLocation(
                    latLng: const LatLng(0, 0),
                    address: '',
                    notes: '',
                    city: '')),
            groomingSchedule: GroomingSchedule(date: DateTime.now(), time: ''),
            carts: const []);

  final PersonalInformation personalInfo;
  final List<OrderServiceModel> carts;
  final GroomingSchedule groomingSchedule;
}

@riverpod
CreateGroomingOrder createGroomingOrder(CreateGroomingOrderRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return CreateGroomingOrder(firestore);
}
