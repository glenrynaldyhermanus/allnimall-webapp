import 'package:allnimall_web/src/data/providers/grooming/service/service_provider_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@riverpod
class Service extends _$Service {
  Service();

  late final FetchServices _fetchServices;

  void init(FetchServices fetchServices) {
    _fetchServices = fetchServices;
  }

  @override
  ServiceProviderState build() {
    return ServiceProviderState.initial();
  }

  Future<void> fetchPetService(String categoryUid) async {
    state = ServiceProviderState.loading();

    final result =
        await _fetchServices(FetchServicesParams(categoryUid: categoryUid));
    result.fold(
      (failure) {
        state = ServiceProviderState.error(failure.message);
      },
      (data) {
        state = ServiceProviderState.success(data);
      },
    );
  }
}
