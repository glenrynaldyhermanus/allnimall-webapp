import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/components/text/rocko_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_headers/sticky_headers.dart';

class DistrictSelectionSheet extends StatefulWidget {
  const DistrictSelectionSheet({super.key, required this.city});

  final String city;

  @override
  DistrictSelectionSheetState createState() => DistrictSelectionSheetState();
}

class DistrictSelectionSheetState extends State<DistrictSelectionSheet> {
  final List<String> jakSelDistrict = [
    'Cilandak',
    'Jagakarsa',
    'Kebayoran Baru',
    'Kebayoran Lama',
    'Mampang Prapatan',
    'Pancoran',
    'Pasar Minggu',
    'Pesanggrahan',
    'Setiabudi',
    'Tebet'
  ];

  final List<String> jakTimDistrict = [
    'Cakung',
    'Cipayung',
    'Ciracas',
    'Duren Sawit',
    'Jatinegara',
    'Kramat Jati',
    'Makasar',
    'Matraman',
    'Pasar Rebo',
    'Pulo Gadung'
  ];

  final List<String> depokDistrict = [
    'Beji',
    'Bojongsari',
    'Cilodong',
    'Cimanggis',
    'Cinere',
    'Cipayung',
    'Limo',
    'Pancoran Mas',
    'Sawangan',
    'Sukmajaya',
    'Tapos'
  ];

  List<String> districts = [];

  @override
  void initState() {
    super.initState();

    if (widget.city == 'Jakarta Selatan') {
      districts = jakSelDistrict;
    } else if (widget.city == 'Jakarta Timur') {
      districts = jakTimDistrict;
    } else if (widget.city == 'Depok') {
      districts = depokDistrict;
    }
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
            header: const SheetHeader(title: 'Pilih kecamatan'),
            content: SheetContent(
              districts: districts,
            ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RockoText(
                      title,
                      fontSize: 18,
                    ),
                    const GeoramaText(
                      'Saat ini kami baru hadir di kecamatan di bawah ini',
                      fontSize: 14,
                    )
                  ],
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
  const SheetContent({super.key, required this.districts});

  final List<String> districts;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        districts.length,
        (index) => ListTile(
          onTap: () {
            context.pop(districts[index]);
          },
          title: GeoramaText(
            districts[index],
            fontSize: 16,
          ),
        ),
      ).divide(const Gap(4)).addToEnd(const Gap(16)),
    );
  }
}
