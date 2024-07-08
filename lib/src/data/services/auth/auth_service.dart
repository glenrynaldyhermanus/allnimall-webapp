// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/services/auth/auth_service_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  ///Usecases

  @override
  AuthServiceState build() {
    return AuthServiceState.initial();
  }

  Future<void> loginByPhone(String phone) async {
    state = AuthServiceState.loading();

    // final result = await _fetchPetCategories();
    // result.fold(
    //       (failure) {
    //     state = AuthServiceState.error(failure.message);
    //   },
    //       (categories) {
    //     state = AuthServiceState.success(categories);
    //   },
    // );
  }

}
