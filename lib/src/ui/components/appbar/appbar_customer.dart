import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:allnimall_web/src/ui/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarCustomer extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustomer({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AllnimallColors.primary,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RockoUltra', color: Colors.white, fontSize: 16),
      ),
      centerTitle: true,
      elevation: 0,
      leading: context.canPop()
          ? InkWell(
              onTap: () {
                context.pop();
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size(double.infinity, AMDimens.kdAppbarHeight);
}
