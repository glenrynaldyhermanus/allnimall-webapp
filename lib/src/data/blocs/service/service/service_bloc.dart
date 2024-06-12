import 'package:allnimall_web/src/data/blocs/service/service/service_event.dart';
import 'package:allnimall_web/src/data/blocs/service/service/service_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ///Usecases
  final FetchServices _fetchServices;

  ///Bloc
  ServiceBloc({
    required FetchServices fetchServices,
  })  : _fetchServices = fetchServices,
        super(ServiceInitialState()) {
    on<ServiceEvent>((event, emit) {
      emit(ServiceLoadingState());
    });

    on<FetchServicesEvent>(_fetchServicesEventHandler);
  }

  ///Handler
  Future<void> _fetchServicesEventHandler(
    FetchServicesEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoadingState());

    try {
      final result = await _fetchServices(
          FetchServicesParams(categoryUid: event.categoryUid));

      result.fold(
        (failure) => emit(ServiceErrorState(failure.errorMessage)),
        (serviceList) => emit(ServicesFetchedState(serviceList)),
      );
    } catch (e) {
      // Handle exceptions if any
      emit(ServiceErrorState('Error occured: $e'));
    }
  }
}
