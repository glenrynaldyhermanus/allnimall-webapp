import 'package:allnimall_web/src/data/usecases/order/add_service_to_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/create_grooming_order.dart';
import 'package:allnimall_web/src/data/usecases/order/get_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/clear_cart.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_pet_categories.dart';
import 'package:allnimall_web/src/data/usecases/service/fetch_services.dart';
import 'package:get_it/get_it.dart';

void initUsecaseModule(GetIt locator) {
  ///order
  locator.registerFactory(() => CreateGroomingOrder(locator()));
  locator.registerFactory(() => AddServiceToCart(locator()));
  locator.registerFactory(() => GetCart(locator()));
  locator.registerFactory(() => ClearCart(locator()));

  ///service
  locator.registerFactory(() => FetchPetCategories(locator()));
  locator.registerFactory(() => FetchServices(locator()));
  // locator.registerFactory(() => ResendOtp(locator()));
  // locator.registerFactory(() => SignIn(locator()));
  // locator.registerFactory(() => SignUp(locator()));
  // locator.registerFactory(() => VerifyOtp(locator()));
  //
  // locator.registerFactory(() => FetchProductCatalogues(locator()));
  //
  // locator.registerFactory(() => CheckBusinessExists(locator()));
  // locator.registerFactory(() => OpenBusiness(locator()));
}
