// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/providers/grooming/service/service_service_state.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_service_provider.g.dart';

@riverpod
class ServiceService extends _$ServiceService {
  late FetchServices _fetchServices;

  @override
  ServiceServiceState build() {
    _fetchServices = ref.watch(fetchServicesProvider);
    return ServiceServiceState.initial();
  }

  Future<void> fetchPetService(String categoryUid) async {
    state = ServiceServiceState.loading();

    final result =
        await _fetchServices(FetchServicesParams(categoryUid: categoryUid));

    result.fold(
      (failure) {
        state = ServiceServiceState.error(failure.message);
      },
      (data) {
        state = ServiceServiceState.success(data);
      },
    );
  }
}
