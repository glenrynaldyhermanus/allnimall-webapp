import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/objects/grooming_schedule.dart';
import 'package:allnimall_web/src/data/objects/personal_information.dart';
import 'package:allnimall_web/src/data/providers/order/order_provider_state.dart';
import 'package:allnimall_web/src/data/usecases/order/create_grooming_order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';

@riverpod
class Order extends _$Order {
  Order();

  ///Usecases
  late final CreateGroomingOrder _createGroomingOrder;

  void init(
    CreateGroomingOrder createGroomingOrder,
  ) {
    _createGroomingOrder = createGroomingOrder;
  }

  @override
  OrderProviderState build() {
    return OrderProviderState.initial();
  }

  Future<void> createGroomingOrder(PersonalInformation personalInformation,
      GroomingSchedule groomingSchedule, List<OrderServiceModel> carts) async {
    state = OrderProviderState.loading();

    final result = await _createGroomingOrder(CreateGroomingOrderParams(
        personalInfo: personalInformation,
        carts: carts,
        groomingSchedule: groomingSchedule));

    result.fold(
      (failure) {
        state = OrderProviderState.error(failure.message);
      },
      (data) {
        state = OrderProviderState.success(data);
      },
    );
  }
}
