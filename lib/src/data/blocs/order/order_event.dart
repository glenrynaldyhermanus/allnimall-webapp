import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/objects/grooming_schedule.dart';
import 'package:allnimall_web/src/data/objects/personal_information.dart';

abstract class OrderEvent {
  const OrderEvent();
}

class CreateGroomingOrderEvent extends OrderEvent {
  const CreateGroomingOrderEvent({
    required this.carts,
    required this.personalInformation,
    required this.groomingSchedule,
  });

  final PersonalInformation personalInformation;
  final GroomingSchedule groomingSchedule;
  final List<OrderServiceModel> carts;
}
