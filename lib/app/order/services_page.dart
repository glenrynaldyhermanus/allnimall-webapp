import 'package:allnimall_web/src/core/extensions/double_ext.dart';
import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/core/utils/functions/count_carts_total_amount.dart';
import 'package:allnimall_web/src/core/utils/functions/count_carts_total_pet.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_bloc.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_event.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_state.dart';
import 'package:allnimall_web/src/data/blocs/service/service/service_bloc.dart';
import 'package:allnimall_web/src/data/blocs/service/service/service_event.dart';
import 'package:allnimall_web/src/data/blocs/service/service/service_state.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/models/service.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/bottomsheet/service_add_on_sheet.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key, this.categoryUid}) : super(key: key);

  final String? categoryUid;

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.categoryUid == null || widget.categoryUid!.isEmpty) {
      context.pushNamed('newOrder');
    } else {
      context
          .read<ServiceBloc>()
          .add(FetchServicesEvent(categoryUid: widget.categoryUid!));
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(CheckCartEvent());
    return Scaffold(
      backgroundColor: AllnimallColors.backgroundPrimary,
      appBar: const AppBarCustomer(title: 'Pilih Servis'),
      body: SafeArea(
        child: BlocConsumer<ServiceBloc, ServiceState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            if (state is ServiceLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ServicesFetchedState) {
              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    children: [
                      const Gap(24),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: GeoramaText(
                          'Pilih servis untuk ${state.serviceList[0].categoryName}-mu',
                          fontSize: 16,
                        ),
                      ),
                      const Gap(8),
                      ...List.generate(
                        state.serviceList.length,
                        (index) =>
                            ServiceRow(service: state.serviceList[index]),
                      )
                          .divide(
                              const Divider(color: AllnimallColors.backgroundOverlay))
                          .around(
                              const Divider(color: AllnimallColors.backgroundOverlay))
                    ],
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
      bottomNavigationBar: const OrderButton(),
    );
  }
}

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          context.pop();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AllnimallColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<CartBloc, CartState>(
              listener: (ctx, state) {},
              builder: (ctx, state) {
                if (state is CartLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<OrderService> carts = [];
                if (state is CartAddedState) {
                  carts = state.carts;
                }

                ///total amount
                double total = countCartsTotalAmount(carts);

                ///total pet
                int totalPet = countCartsTotalPet(carts);


                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeoramaText(
                      '${carts.length} services | $totalPet pet',
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        GeoramaText(
                          total.toRupiahString(),
                          color: Colors.white,
                        ),
                        const Gap(8),
                        const Icon(
                          Icons.arrow_circle_right,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceRow extends StatelessWidget {
  const ServiceRow({super.key, required this.service});

  final Service service;

  IconData getIcons(String type) {
    switch (type) {
      case 'bath':
        return FontAwesomeIcons.shower;
      case 'cut':
        return FontAwesomeIcons.scissors;
      default:
        return FontAwesomeIcons.icons;
    }
  }

  bool isAddedToCart(List<OrderService> carts, Service service) {
    for (var cart in carts) {
      if (cart.serviceUid == service.id) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          List<OrderService> carts = [];
          if (state is CartAddedState) {
            carts = state.carts;
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AllnimallColors.backgroundOverlay,
                  ),
                  child: Center(
                    child: FaIcon(
                      getIcons(service.type),
                      size: 12,
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeoramaText(
                        service.name,
                        fontSize: 14,
                      ),
                      GeoramaText(
                        service.description,
                        fontSize: 12,
                        color: AllnimallColors.textSecondary,
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Column(
                  children: [
                    GeoramaText(
                      service.fee.toRupiahString(),
                      fontSize: 12,
                      color: AllnimallColors.secondary,
                    ),
                    const Gap(4),
                    OutlinedButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: true,
                          context: context,
                          builder: (bottomSheetContext) {
                            return ServiceAddOnSheet(
                              service: service,
                              carts: carts,
                            );
                          },
                        ).then((value) =>
                            context.read<CartBloc>().add(CheckCartEvent()));
                      },
                      style: isAddedToCart(carts, service)
                          ? FilledButton.styleFrom(
                              backgroundColor: AllnimallColors.primary)
                          : OutlinedButton.styleFrom(
                              side: const BorderSide(color: AllnimallColors.primary),
                            ),
                      child: GeoramaText(
                        isAddedToCart(carts, service) ? 'Edit' : 'Add',
                        fontSize: 11,
                        color: isAddedToCart(carts, service)
                            ? Colors.white
                            : AllnimallColors.primary,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
