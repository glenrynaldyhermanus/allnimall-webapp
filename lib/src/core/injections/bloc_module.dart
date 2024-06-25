import 'package:allnimall_web/src/data/blocs/cart/cart_bloc.dart';
import 'package:allnimall_web/src/data/blocs/order/order_bloc.dart';
import 'package:allnimall_web/src/data/blocs/service/category/category_bloc.dart';
import 'package:allnimall_web/src/data/blocs/service/service/service_bloc.dart';
import 'package:get_it/get_it.dart';

void initBlocModule(GetIt locator) {
  locator.registerFactory(
    () => CartBloc(addServiceToCart: locator(), getCart: locator()),
  );
  locator.registerFactory(
    () => CategoryBloc(
      fetchPetCategories: locator(),
    ),
  );
  locator.registerFactory(
    () => ServiceBloc(
      fetchServices: locator(),
    ),
  );
  locator.registerFactory(
    () => OrderBloc(
      createGroomingOrder: locator(),
    ),
  );
  // locator.registerFactory(
  //   () => ProductBloc(
  //     checkSession: locator(),
  //     fetchProduct: locator(),
  //   ),
  // );
}
