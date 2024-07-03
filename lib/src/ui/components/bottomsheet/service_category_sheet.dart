import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/data/models/service_category.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/components/text/rocko_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ServiceCategorySheet extends StatefulWidget {
  const ServiceCategorySheet({super.key, required this.serviceCategories});

  final List<ServiceCategoryModel> serviceCategories;

  @override
  ServiceCategorySheetState createState() => ServiceCategorySheetState();
}

class ServiceCategorySheetState extends State<ServiceCategorySheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AllnimallColors.backgroundPrimary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: StickyHeader(
            header: const SheetHeader(title: 'Pilih salah satu'),
            content: SheetContent(serviceCategories: widget.serviceCategories),
          ),
        ),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AllnimallColors.backgroundPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                RockoText(
                  title,
                  fontSize: 18,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}

class SheetContent extends StatelessWidget {
  const SheetContent({super.key, required this.serviceCategories});

  final List<ServiceCategoryModel> serviceCategories;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        serviceCategories.length,
        (index) =>
            ServiceCategoryCard(serviceCategory: serviceCategories[index]),
      ).divide(const Gap(8)).addToEnd(const Gap(16)),
    );
  }
}

class ServiceCategoryCard extends StatelessWidget {
  const ServiceCategoryCard({
    super.key,
    required this.serviceCategory,
  });

  final ServiceCategoryModel serviceCategory;

  String getIconAsset(int sequence) {
    switch (sequence) {
      case 2:
        return 'images/ic_dog_small.png';
      case 3:
        return 'images/ic_dog_medium.png';
      case 4:
        return 'images/ic_dog_large.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: InkWell(
        onTap: () {
          context.pushNamed('selectService', queryParameters: {
            'categoryUid': serviceCategory.id
          }).then((value) => context.pop());
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
                    child: Image.asset(
                      getIconAsset(serviceCategory.sequence),
                      height: 16,
                      width: 16,
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: GeoramaText(
                    serviceCategory.name,
                    fontSize: 16,
                  ),
                ),
                GeoramaText(
                  serviceCategory.description,
                  fontSize: 12,
                  color: AllnimallColors.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
