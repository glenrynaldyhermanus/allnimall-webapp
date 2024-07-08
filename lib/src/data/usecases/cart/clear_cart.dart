import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/preferences/shared_preferences.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clear_cart.g.dart';

class ClearCart extends UsecaseWithoutParams<List<OrderServiceModel>> {
  const ClearCart(this.preferences);

  final AMPreferences preferences;

  @override
  ResultFuture<List<OrderServiceModel>> call() async {
    try {
      preferences.deleteSecureData(PrefKey.cart);
      return const Right([]);
    } catch (e) {
      logger.e("addServiceToCart => $e");
      return Left(CacheFailure(
          message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
          statusCode: 500));
    }
  }
}

@riverpod
ClearCart clearCart(ClearCartRef ref) {
  final provider = ref.watch(amPreferencesProvider);
  return ClearCart(provider);
}
