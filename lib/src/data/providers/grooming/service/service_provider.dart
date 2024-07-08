// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/providers/grooming/service/service_provider_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@riverpod
class Service extends _$Service {
  late FetchServices _fetchServices;

  @override
  ServiceProviderState build() {
    _fetchServices = ref.watch(fetchServicesProvider);
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
