import 'package:allnimall_web/src/core/extensions/double_ext.dart';
import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/core/utils/functions/run_on_page_load.dart';
import 'package:allnimall_web/src/data/models/pet_category.dart';
import 'package:allnimall_web/src/data/services/grooming/category/category_service.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/bottomsheet/service_category_sheet.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PetCategoriesPage extends ConsumerStatefulWidget {
  const PetCategoriesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PetCategoriesPage> createState() => _PetCategoriesPageState();
}

class _PetCategoriesPageState extends ConsumerState<PetCategoriesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    onPageLoaded(() => ref.read(categoryServiceProvider.notifier).fetchPetCategory());
  }

  @override
  Widget build(BuildContext context) {
    final categoryProviderState = ref.watch(categoryServiceProvider);

    return Scaffold(
      backgroundColor: AllnimallColors.backgroundPrimary,
      appBar: const AppBarCustomer(title: 'Pilih Kategori'),
      body: SafeArea(
        child: categoryProviderState.when(
          initial: () => Container(),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (categories) => Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ListView(
                children: [
                  const Gap(24),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: GeoramaText(
                      'Pilih kategori Pet',
                      fontSize: 16,
                    ),
                  ),
                  const Gap(8),
                  ...List.generate(
                    categories.length,
                    (index) => CategoryCard(petCategory: categories[index]),
                  ).divide(const Gap(8))
                ],
              ),
            ),
          ),
          error: (message) => Container(),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.petCategory});

  final PetCategoryModel petCategory;

  IconData getIcons(int sequence) {
    switch (sequence) {
      case 1:
        return FontAwesomeIcons.cat;
      case 2:
        return FontAwesomeIcons.dog;
      default:
        return FontAwesomeIcons.icons;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: InkWell(
        onTap: () async {
          if (petCategory.services != null) {
            if (petCategory.services!.length == 1) {
              context.pushNamed('selectService', queryParameters: {
                'categoryUid': petCategory.services![0].id
              }).then((value) => {context.pop()});
            } else if (petCategory.services!.length > 1) {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                enableDrag: true,
                context: context,
                builder: (bottomSheetContext) {
                  return ServiceCategorySheet(
                    serviceCategories: petCategory.services!,
                  );
                },
              ).then((value) => context.pop());
            }
          }
        },
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 8,
          shadowColor: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                      getIcons(petCategory.sequence),
                      size: 16,
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: GeoramaText(petCategory.name, fontSize: 16),
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GeoramaText(
                      'Mulai dari',
                      fontSize: 10,
                    ),
                    GeoramaText(
                      petCategory.startFrom.toRupiahString(),
                      fontSize: 12,
                      color: AllnimallColors.secondary,
                    ),
                  ],
                ),
                const Gap(8),
                const Icon(Icons.chevron_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
