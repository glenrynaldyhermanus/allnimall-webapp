import 'package:allnimall_web/src/data/blocs/order/order_bloc.dart';
import 'package:get_it/get_it.dart';

void initBlocModule(GetIt locator) {
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
