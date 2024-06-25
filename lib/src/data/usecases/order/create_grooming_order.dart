import 'package:allnimall_web/src/core/utils/functions/count_carts_total_pet.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/objects/grooming_schedule.dart';
import 'package:allnimall_web/src/data/objects/personal_information.dart';
import 'package:allnimall_web/src/data/objects/personal_location.dart';
import 'package:allnimall_web/src/data/repositories/order_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateGroomingOrder
    extends UsecaseWithParams<void, CreateGroomingOrderParams> {
  const CreateGroomingOrder(this._repo);

  final OrderRepository _repo;

  @override
  ResultFuture<void> call(CreateGroomingOrderParams params) =>
      _repo.createGroomingOrder(
          order: GroomingOrder(
              amount: countCartsTotalPet(params.carts),
              createdAt: DateTime.now(),
              customerAddress: params.personalInfo.location.address,
              customerCity: params.personalInfo.location.city,
              customerLatLng: params.personalInfo.location.latLng,
              customerName: params.personalInfo.name,
              customerPhone: params.personalInfo.phone,
              name: 'groomingSchedule',
              notes: 'notes',
              orderNo: 'orderNo',
              paymentStatus: "Unpaid",
              petCategory: 'Kucing',
              preferredDay: "Weekday",
              preferredTime: "Pagi",
              quantity: countCartsTotalPet(params.carts),
              scheduledAt: params.groomingSchedule.date,
              service: 'Grooming',
              status: 'New'));
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
  final List<OrderService> carts;
  final GroomingSchedule groomingSchedule;
}
