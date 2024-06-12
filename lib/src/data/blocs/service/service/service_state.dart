import 'package:allnimall_web/src/data/models/service.dart';

abstract class ServiceState {
  const ServiceState();
}

class ServiceInitialState extends ServiceState {}

class ServiceLoadingState extends ServiceState {}

class ServicesFetchedState extends ServiceState {
  const ServicesFetchedState(this.serviceList);

  final List<Service> serviceList;
}

class ServiceUnauthenticatedState extends ServiceState {}

class ServiceErrorState extends ServiceState {
  const ServiceErrorState(this.message);

  final String message;
}
