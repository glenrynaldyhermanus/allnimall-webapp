import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/data/objects/menu.dart';
import 'package:allnimall_web/src/ui/components/padding/content_padding.dart';
import 'package:allnimall_web/src/ui/components/text/text_button_primary.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuHome extends StatefulWidget {
  const MenuHome({Key? key}) : super(key: key);

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  List<Menu> menus = [
    Menu(index: 0, name: "Home", path: "home"),
    Menu(index: 1, name: "Layanan", path: "service"),
    Menu(index: 2, name: "Harga", path: "pricing"),
    Menu(index: 3, name: "Testimoni", path: "testimonial"),
    Menu(index: 4, name: "Order", path: "order", newPage: true)
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentPadding(
      child: Row(
        children: List.generate(
          menus.length,
          (index) => TextButton(
            onPressed: () {
              if (menus[index].newPage) {
                context.pushNamed('newOrder');
              } else {
                context.read<ValueNotifier<Menu>>().value = menus[index];
              }
            },
            child: TextButtonPrimary(menus[index].name,
                isSelected:
                    context.watch<ValueNotifier<Menu>>().value.index == index),
          ),
        ).divide(const Gap(8)),
      ),
    );
  }
}
