import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verify_phone.g.dart';

class VerifyPhone extends UsecaseWithParams<void, VerifyPhoneParams> {
  VerifyPhone();

  @override
  ResultFuture<void> call(VerifyPhoneParams params) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: params.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          params.onCodeSent(verificationId, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          params.onCodeAutoRetrievalTimeout(verificationId);
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(
        message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
        statusCode: 500,
      ));
    }
  }
}

class VerifyPhoneParams {
  const VerifyPhoneParams({
    required this.phone,
    required this.onCodeSent,
    required this.onCodeAutoRetrievalTimeout,
  });

  final String phone;
  final Function(String verificationId, int? resendToken) onCodeSent;
  final Function(String verificationId) onCodeAutoRetrievalTimeout;
}

@riverpod
VerifyPhone verifyPhone(VerifyPhoneRef ref) {
  //final repo = ref.watch(authRepositoryProvider);
  return VerifyPhone();
}
