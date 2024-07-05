import 'package:allnimall_web/app/json/get_json_page.dart';
import 'package:allnimall_web/app/order/detail/order_detail_page.dart';
import 'package:allnimall_web/app/order/new/customer/personal_information_page.dart';
import 'package:allnimall_web/app/order/new/customer/personal_location_page.dart';
import 'package:allnimall_web/app/order/new/new_order_page.dart';
import 'package:allnimall_web/app/order/new/pet_categories_page.dart';
import 'package:allnimall_web/app/order/new/schedule/grooming_schedule_page.dart';
import 'package:allnimall_web/app/order/new/services_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (ctx, state) => const NewOrderPage(),
    ),
    GoRoute(
      name: 'newOrder',
      path: '/order/new',
      builder: (ctx, state) => const NewOrderPage(),
      routes: [
        GoRoute(
          name: 'selectCategory',
          path: 'category',
          builder: (ctx, state) => const PetCategoriesPage(),
          routes: [
            GoRoute(
              name: 'selectService',
              path: 'service',
              builder: (ctx, state) => ServicesPage(
                categoryUid: state.uri.queryParameters['categoryUid'] ?? '',
              ),
            ),
          ],
        ),
        GoRoute(
          name: 'customerInformation',
          path: 'customer/info',
          builder: (ctx, state) => const PersonalInformationPage(),
          routes: [
            GoRoute(
              name: 'customerLocation',
              path: 'location',
              builder: (ctx, state) => const PersonalLocationPage(),
            ),
          ],
        ),
        GoRoute(
          name: 'groomingSchedule',
          path: 'schedule',
          builder: (ctx, state) => const GroomingSchedulePage(),
        ),
      ],
    ),
    GoRoute(
      name: 'orderDetail',
      path: '/order/detail',
      builder: (ctx, state) => const OrderDetailPage(),
    ),
    GoRoute(
      path: '/test/json',
      builder: (ctx, state) =>
          GetJsonPage(tableName: state.uri.queryParameters['tableName'] ?? ''),
    ),
  ],
);
