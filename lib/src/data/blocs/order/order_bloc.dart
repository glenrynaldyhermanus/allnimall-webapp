import 'package:allnimall_web/src/data/blocs/order/order_event.dart';
import 'package:allnimall_web/src/data/blocs/order/order_state.dart';
import 'package:allnimall_web/src/data/usecases/order/create_grooming_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  ///Usecases
  final CreateGroomingOrder _createGroomingOrder;

  ///Bloc
  OrderBloc({
    required CreateGroomingOrder createGroomingOrder,
  })  : _createGroomingOrder = createGroomingOrder,
        super(OrderInitialState()) {
    on<OrderEvent>((event, emit) {
      emit(OrderLoadingState());
    });

    on<CreateGroomingOrderEvent>(_createGroomingOrderEventHandler);
  }

  ///Handler
  Future<void> _createGroomingOrderEventHandler(
    CreateGroomingOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoadingState());

    try {
      final result = await _createGroomingOrder(CreateGroomingOrderParams(
          personalInfo: event.personalInformation,
          carts: event.carts,
          groomingSchedule: event.groomingSchedule));

      result.fold(
        (failure) => emit(OrderErrorState(failure.errorMessage)),
        (order) => emit(OrderCreatedState(order)),
      );
    } catch (e) {
      // Handle exceptions if any
      emit(OrderErrorState('Error occured: $e'));
    }
  }
}
