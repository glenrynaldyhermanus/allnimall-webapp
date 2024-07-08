// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/services/auth/auth_service_state.dart';
import 'package:allnimall_web/src/data/usecases/auth/verify_phone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  ///Usecases
  late VerifyPhone _verifyPhone;

  @override
  AuthServiceState build() {
    return AuthServiceState.initial();
  }

  Future<void> loginByPhone(String phone) async {
    state = AuthServiceState.loading();

    final result = await _verifyPhone(
      VerifyPhoneParams(
        phone: phone,
        onCodeSent: (verificationId, codeSent) {},
        onCodeAutoRetrievalTimeout: (verificationId) {},
      ),
    );
    result.fold(
      (failure) {
        state = AuthServiceState.error(failure.message);
      },
      (_) {
        state = AuthServiceState.success("Success");
      },
    );
  }
}
