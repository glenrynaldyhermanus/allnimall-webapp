import 'package:allnimall_web/src/data/models/service_add_on.dart';

bool isAddOnExistsInCart(List<ServiceAddOnModel> cartAddOns, String uid) {
  return cartAddOns.any((item) {
    return item.id == uid;
  });
}
