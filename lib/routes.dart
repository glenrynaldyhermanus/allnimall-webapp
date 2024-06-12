import 'package:allnimall_web/app/order/customer/personal_information_page.dart';
import 'package:allnimall_web/app/json/get_json_page.dart';
import 'package:allnimall_web/app/order/new_order_page.dart';
import 'package:allnimall_web/app/order/pet_categories_page.dart';
import 'package:allnimall_web/app/order/services_page.dart';
import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_bloc.dart';
import 'package:allnimall_web/src/data/blocs/service/category/category_bloc.dart';
import 'package:allnimall_web/src/data/blocs/service/service/service_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (ctx, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<CartBloc>()),
          BlocProvider(create: (_) => locator<CategoryBloc>()),
        ],
        child: const NewOrderPage(),
      ),
    ),
    GoRoute(
      name: 'newOrder',
      path: '/order/new',
      builder: (ctx, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<CartBloc>()),
          BlocProvider(create: (_) => locator<CategoryBloc>()),
        ],
        child: const NewOrderPage(),
      ),
      routes: [
        GoRoute(
          name: 'selectCategory',
          path: 'category',
          builder: (ctx, state) => BlocProvider(
            create: (_) => locator<CategoryBloc>(),
            child: const PetCategoriesPage(),
          ),
          routes: [
            GoRoute(
              name: 'selectService',
              path: 'service',
              builder: (ctx, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => locator<CartBloc>()),
                  BlocProvider(create: (_) => locator<ServiceBloc>()),
                ],
                child: ServicesPage(
                  categoryUid: state.uri.queryParameters['categoryUid'] ?? '',
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          name: 'phoneAuth',
          path: 'phone/auth',
          builder: (ctx, state) => const PersonalInformationPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/test/json',
      builder: (ctx, state) =>
          GetJsonPage(tableName: state.uri.queryParameters['tableName'] ?? ''),
    ),
  ],
);
