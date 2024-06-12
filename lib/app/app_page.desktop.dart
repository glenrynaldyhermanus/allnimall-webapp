import 'package:allnimall_web/src/core/extensions/double_ext.dart';
import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/data/objects/menu.dart';
import 'package:allnimall_web/src/ui/components/padding/content_padding.dart';
import 'package:allnimall_web/src/ui/components/text/text_button_primary.dart';
import 'package:allnimall_web/src/ui/components/text/text_section_title.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:allnimall_web/src/ui/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:styled_divider/styled_divider.dart';

class AppPageDesktop extends StatefulWidget {
  const AppPageDesktop({Key? key}) : super(key: key);

  @override
  State<AppPageDesktop> createState() => _AppPageDesktopState();
}

class _AppPageDesktopState extends State<AppPageDesktop> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _scrollToSection(int index) {
    double offset =
        index * (MediaQuery.of(context).size.height - AMDimens.kdAppbarHeight);

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Menu>(
        valueListenable: context.watch<ValueNotifier<Menu>>(),
        builder: (context, selectedMenu, child) {
          _scrollToSection(selectedMenu.index);
          return ListView(
            controller: _scrollController,
            children: const [
              BannerSection(),
              ServiceSection(),
              PricingSection(),
              TestimonialSection(),
            ],
          );
        });
  }
}

class BannerSection extends StatefulWidget {
  const BannerSection({Key? key}) : super(key: key);

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - AMDimens.kdAppbarHeight,
      width: double.infinity,
      child: Image.network(
          'https://assets.petco.com/petco/image/upload/f_auto,q_auto:best,dpr_2.0,w_800/AdobeStock_334038158.jpeg',
          fit: BoxFit.cover),
    );
  }
}

class OrderSection extends StatefulWidget {
  const OrderSection({Key? key}) : super(key: key);

  @override
  State<OrderSection> createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - AMDimens.kdAppbarHeight,
      width: double.infinity,
      child: const ContentPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(AMDimens.kdAppbarHeight),
          ],
        ),
      ),
    );
  }
}

class PricingSection extends StatefulWidget {
  const PricingSection({Key? key}) : super(key: key);

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - AMDimens.kdAppbarHeight,
      width: double.infinity,
      child: ContentPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextSectionTitle('Price list'),
            Row(
                children: [
              const Expanded(child: PricingCatCard()),
              // const Expanded(child: PricingDogCard())
            ].divide(const Gap(16))),
          ].divide(const Gap(16)).around(const Gap(AMDimens.kdAppbarHeight)),
        ),
      ),
    );
  }
}

class PricingCatCard extends StatelessWidget {
  const PricingCatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AllnimallColors.primary.withOpacity(0.1),
              spreadRadius: 16,
              offset: const Offset(0, 16),
              blurRadius: 64,
            )
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    TextButtonPrimary('Mau Grooming Kucing?', fontSize: 20)
                  ],
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PriceCatRow(
                        title: 'Mandi Sehat',
                        description:
                            'Mandi + Potong Kuku + Bersihkan Telinga + Cukur Bulu Pantat + Dikeringkan + Perfume',
                        price: 65000),
                    const PriceCatRow(
                        title: 'Mandi Kutu (+Shampoo Kutu)',
                        description: 'Grooming Sehat + Shampoo Kutu',
                        price: 85000),
                    const PriceCatRow(
                        title: 'Mandi Jamur (+Shampoo Jamur)',
                        description: 'Grooming Sehat + Shampoo Jamur',
                        price: 85000),
                    const PriceCatRow(
                        title: 'Mandi Lengkap (+Shampoo Jamur & Kutu)',
                        description:
                            'Grooming Sehat + Shampoo Kutu + Shampoo Jamur',
                        price: 100000),
                  ].divide(const Gap(16)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextButtonPrimary('Cukur Bulu', fontSize: 16),
                        const PriceCatRow(
                            title: 'Cukur Minor',
                            description: 'Merapihkan Bulu',
                            price: 100000),
                        const PriceCatRow(
                            title: 'Cukur Major',
                            description: 'Cukur Sampai Botak',
                            price: 150000),
                        const PriceCatRow(
                            title: 'Cukur Style',
                            description:
                                'Opsi style yang tersedia (lion cut / teddy bear cut)',
                            price: 200000),
                      ].divide(const Gap(16)),
                    ),
                  ].divide(const Gap(16)),
                ),
              ],
            ),
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.0, color: AllnimallColors.primary),
              ),
              onPressed: () {
                context.read<ValueNotifier<Menu>>().value =
                    Menu(index: 4, name: "Order", path: "order");
              },
              child: const TextButtonPrimary('Order Sekarang')),
          const Gap(16)
        ].divide(const Gap(8)),
      ),
    );
  }
}

class PriceCatRow extends StatelessWidget {
  const PriceCatRow(
      {super.key, required this.title, this.description, required this.price});

  final String title;
  final String? description;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButtonPrimary(title),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (description != null)
                    Text(
                      description!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  const StyledDivider(
                    color: Colors.black,
                    height: 4,
                    thickness: 2,
                    lineStyle: DividerLineStyle.dotted,
                    indent: 2,
                    endIndent: 2,
                  ),
                  const Gap(4)
                ],
              ),
            ),
            const Gap(24),
            Expanded(
                flex: 1,
                child: TextButtonPrimary(price.toRupiahString(), fontSize: 18)),
          ],
        )
      ],
    );
  }
}

class PricingDogCard extends StatelessWidget {
  const PricingDogCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AllnimallColors.primary.withOpacity(0.1),
              spreadRadius: 16,
              offset: const Offset(0, 16),
              blurRadius: 64,
            )
          ]),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextButtonPrimary('Grooming Kucing'),
              ],
            ),
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.0, color: AllnimallColors.primary),
              ),
              onPressed: () {
                context.read<ValueNotifier<Menu>>().value =
                    Menu(index: 4, name: "Order", path: "order");
              },
              child: const TextButtonPrimary('Order Sekarang')),
          const Gap(16)
        ].divide(const Gap(8)),
      ),
    );
  }
}

class ServiceSection extends StatefulWidget {
  const ServiceSection({Key? key}) : super(key: key);

  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - AMDimens.kdAppbarHeight,
      width: double.infinity,
      child: ContentPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextSectionTitle('Layanan'),
            const Gap(64),
            Row(
              children: [
                const Expanded(
                  child: ServiceCard(
                      title: 'Salon Anabul',
                      body:
                          'Cukur bulu anabul kamu untuk kesehatan maupun untuk membuat anabul tampil lebih bergaya.',
                      imageUrl:
                          'https://assets.petco.com/petco/image/upload/f_auto,q_auto:best,dpr_2.0,w_800/AdobeStock_334038158.jpeg'),
                ),
                const Expanded(
                  child: ServiceCard(
                      title: 'Groomer Panggilan',
                      body:
                          'Panggil groomer kami ke rumah kamu, dan kamu bisa memantau langsung anabul.',
                      imageUrl:
                          'https://assets.petco.com/petco/image/upload/f_auto,q_auto:best,dpr_2.0,w_800/AdobeStock_334038158.jpeg'),
                ),
                const Expanded(
                  child: ServiceCard(
                      title: 'Monitor Anabul',
                      body:
                          'Melalui aplikasi Allnimall, kamu bisa mencatat & melihat perkembangan anabul.',
                      imageUrl:
                          'https://assets.petco.com/petco/image/upload/f_auto,q_auto:best,dpr_2.0,w_800/AdobeStock_334038158.jpeg'),
                ),
              ].divide(const Gap(16)),
            )
          ]
              .divide(const Gap(AMDimens.kdAppbarHeight))
              .around(const Gap(AMDimens.kdAppbarHeight)),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.body,
  });

  final String imageUrl;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AllnimallColors.primary.withOpacity(0.1),
              spreadRadius: 16,
              offset: const Offset(0, 16),
              blurRadius: 64,
            )
          ]),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
            child: Image.network(imageUrl,
                height: 264, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextButtonPrimary(title),
                Text(body, textAlign: TextAlign.center),
              ],
            ),
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 1.0, color: AllnimallColors.primary),
              ),
              onPressed: () {
                context.read<ValueNotifier<Menu>>().value =
                    Menu(index: 2, name: "Harga", path: "pricing");
              },
              child: const TextButtonPrimary('Lihat Harga')),
          const Gap(16)
        ].divide(const Gap(8)),
      ),
    );
  }
}

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({Key? key}) : super(key: key);

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - AMDimens.kdAppbarHeight,
      width: double.infinity,
      child: ContentPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(AMDimens.kdAppbarHeight),
            const TextSectionTitle('Testimonial'),
            const Gap(32),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset('assets/images/im_testimoni_1.png'),
                  ),
                ),
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child:
                            Image.asset('assets/images/im_testimoni_2.png'))),
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset('assets/images/im_testimoni_3.png')))
              ].divide(const Gap(32)),
            )
          ],
        ),
      ),
    );
  }
}
