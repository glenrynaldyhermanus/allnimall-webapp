import 'package:allnimall_web/src/ui/components/menu/menu_home.dart';
import 'package:allnimall_web/src/ui/components/padding/content_padding.dart';
import 'package:allnimall_web/src/ui/helpers/screens.dart';
import 'package:allnimall_web/src/ui/res/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.dark
            : Brightness.light,
      ),
      title: ContentPadding(
          child: Image.asset(
        'assets/images/ic_logo.png',
        width: 120,
        fit: BoxFit.cover,
      )),
      actions: !AMScreens.of(context).isMobile ? const [MenuHome()] : [],
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      const Size(double.infinity, AMDimens.kdAppbarHeight);
}
