// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/objects/grooming_schedule.dart';
import 'package:allnimall_web/src/data/objects/personal_information.dart';
import 'package:allnimall_web/src/data/providers/order/order_service_state.dart';
import 'package:allnimall_web/src/data/usecases/order/create_grooming_order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_service_provider.g.dart';

@riverpod
class OrderService extends _$OrderService {
  late CreateGroomingOrder _createGroomingOrder;

  @override
  OrderServiceState build() {
    _createGroomingOrder = ref.watch(createGroomingOrderProvider);
    return OrderServiceState.initial();
  }

  Future<void> createGroomingOrder(PersonalInformation personalInformation,
      GroomingSchedule groomingSchedule, List<OrderServiceModel> carts) async {
    state = OrderServiceState.loading();

    final result = await _createGroomingOrder(CreateGroomingOrderParams(
        personalInfo: personalInformation,
        carts: carts,
        groomingSchedule: groomingSchedule));

    result.fold(
      (failure) {
        state = OrderServiceState.error(failure.message);
      },
      (data) {
        state = OrderServiceState.success(data);
      },
    );
  }
}
