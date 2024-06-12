abstract class ServiceEvent {
  const ServiceEvent();
}

class FetchServicesEvent extends ServiceEvent {
  const FetchServicesEvent({required this.categoryUid});

  final String categoryUid;
}
