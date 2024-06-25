import 'package:allnimall_web/src/core/extensions/double_ext.dart';
import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/core/utils/functions/count_carts_service_amount.dart';
import 'package:allnimall_web/src/core/utils/functions/count_carts_total_amount.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_bloc.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_event.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_state.dart';
import 'package:allnimall_web/src/data/blocs/order/order_bloc.dart';
import 'package:allnimall_web/src/data/blocs/order/order_event.dart';
import 'package:allnimall_web/src/data/blocs/order/order_state.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/objects/grooming_schedule.dart';
import 'package:allnimall_web/src/data/objects/personal_information.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/button/allnimall_primary_button.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:styled_divider/styled_divider.dart';

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({Key? key}) : super(key: key);

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  List<OrderService>? carts;
  PersonalInformation? personalInfo;
  GroomingSchedule? groomingSchedule;

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(CheckCartEvent());
    return Scaffold(
      backgroundColor: AllnimallColors.backgroundPrimary,
      appBar: const AppBarCustomer(title: 'Pet Grooming'),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const ImageBanner(),
                      ...[
                        const InformationCard(),
                        ServiceCard(
                          onSet: (carts) {
                            this.carts = carts;
                          },
                        ),
                        CustomerCard(
                          onSet: (personalInfo) {
                            this.personalInfo = personalInfo;
                          },
                        ),
                        ScheduleCard(
                          onSet: (groomingSchedule) {
                            this.groomingSchedule = groomingSchedule;
                          },
                        ),
                      ].divide(const Gap(8)),
                    ],
                  ),
                ),
                BlocConsumer(
                    bloc: context.read<OrderBloc>(),
                    listener: (context, state) {
                      if(state is OrderCreatedState){
                        context.pushNamed('orderDetail');
                      }
                    },
                    builder: (context, state) {
                      if (state is OrderLoadingState) {
                        return const CircularProgressIndicator();
                      }

                      return AllnimallPrimaryButton(
                        'Panggil groomer',
                        outsidePadding: const EdgeInsets.all(24),
                        onPressed: () {
                          if (carts == null ||
                              personalInfo == null ||
                              groomingSchedule == null) {
                            Fluttertoast.showToast(
                                msg: "Mohon isi data terlebih dahulu",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          } else {
                            context.read<OrderBloc>().add(
                                CreateGroomingOrderEvent(
                                    carts: carts!,
                                    personalInformation: personalInfo!,
                                    groomingSchedule: groomingSchedule!));
                          }
                        },
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageBanner extends StatelessWidget {
  const ImageBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://i.ibb.co.com/FnZz0bc/gromming-banner-1.jpg',
      height: 240,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GeoramaText(
              'Pet Grooming',
              fontSize: 16,
            ),
            const Gap(4),
            const GeoramaText(
              'Memandikan dan merawat anabul kesayangan. Groomer kami akan datang ke rumahmu.',
              fontSize: 12,
            ),
            const Gap(4),
            Card(
              color: Colors.white,
              surfaceTintColor: AllnimallColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              margin: EdgeInsets.zero,
              shadowColor: Colors.black12,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: GeoramaText(
                  'Kami merekomendasikan grooming minimal 1 bulan sekali. Atau 2 minggu sekali jika memiliki kutu atau jamur.',
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  const ServiceCard({super.key, required this.onSet});

  final Function(List<OrderService>) onSet;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .pushNamed('selectCategory')
            .then((value) => context.read<CartBloc>().add(CheckCartEvent()));
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 4,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {},
              builder: (context, state) {
                List<OrderService> carts = [];
                if (state is CartAddedState) {
                  carts = state.carts;
                  widget.onSet(carts);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GeoramaText(
                            carts.isNotEmpty
                                ? ' ${carts.length} layanan terpilih'
                                : 'Pilih layanan',
                            fontSize: 16,
                          ),
                        ),
                        const Gap(16),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                    if (carts.isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(
                              carts.length,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: GeoramaText(
                                            carts[index].categoryName),
                                      ),
                                      const Expanded(
                                          flex: 1, child: GeoramaText(" | ")),
                                      Expanded(
                                        flex: 8,
                                        child: Row(
                                          children: [
                                            GeoramaText(
                                                carts[index].name.trim()),
                                            GeoramaText(
                                                ' x ${carts[index].quantity}'),
                                          ],
                                        ),
                                      ),
                                      GeoramaText(
                                          countCartsServiceAmount(carts[index])
                                              .toRupiahString()),
                                    ],
                                  ),
                                  if (carts[index].addOns.isNotEmpty)
                                    ...List.generate(
                                        carts[index].addOns.length,
                                        (aIndex) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4),
                                              child: GeoramaText(
                                                  ' + ${carts[index].addOns[aIndex].name}'),
                                            ))
                                ],
                              ),
                            ),
                            const Gap(8),
                            const Row(
                              children: [
                                Expanded(flex: 2, child: SizedBox()),
                                Expanded(
                                    child: StyledDivider(
                                  height: 4,
                                  thickness: 1,
                                  lineStyle: DividerLineStyle.dashed,
                                ))
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                const Expanded(
                                    child: GeoramaText(
                                  'Total',
                                  fontWeight: FontWeight.bold,
                                )),
                                GeoramaText(
                                  countCartsTotalAmount(carts).toRupiahString(),
                                  fontWeight: FontWeight.bold,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class CustomerCard extends StatefulWidget {
  const CustomerCard({super.key, required this.onSet});

  final Function(PersonalInformation) onSet;

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  PersonalInformation? personalInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed('customerInformation').then((value) => setState(() {
              if (value != null && value is PersonalInformation) {
                personalInfo = value;
                widget.onSet(value);
              }
            }));
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 4,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: GeoramaText(
                      'Informasi personal',
                      fontSize: 16,
                    ),
                  ),
                  Gap(16),
                  Icon(Icons.chevron_right)
                ],
              ),
              if (personalInfo != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeoramaText(personalInfo!.name),
                      GeoramaText('0${personalInfo!.phone}'),
                      GeoramaText(personalInfo!.location.address),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.onSet});

  final Function(GroomingSchedule) onSet;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  GroomingSchedule? groomingSchedule;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed('groomingSchedule').then(
              (value) => setState(
                () {
                  if (value != null && value is GroomingSchedule) {
                    groomingSchedule = value;
                    widget.onSet(value);
                  }
                },
              ),
            );
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 4,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: GeoramaText(
                      'Jadwal grooming',
                      fontSize: 16,
                    ),
                  ),
                  Gap(16),
                  Icon(Icons.chevron_right)
                ],
              ),
              if (groomingSchedule != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeoramaText(DateFormat('EEEE, dd MMM')
                          .format(groomingSchedule!.date)),
                      GeoramaText(groomingSchedule!.time),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
