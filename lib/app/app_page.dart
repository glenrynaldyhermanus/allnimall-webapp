import 'package:allnimall_web/app/app_page.desktop.dart';
import 'package:allnimall_web/src/data/objects/menu.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_home.dart';
import 'package:allnimall_web/src/ui/layouts/allnimall_scaffold.dart';
import 'package:allnimall_web/src/ui/layouts/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    // try {
    //   print('FirebaseAuth.instance.currentUser start');
    //   var user = FirebaseAuth.instance.currentUser;
    //   print(user);
    //   print('FirebaseAuth.instance.currentUser end');
    // } catch (e) {
    //   if (e is FirebaseException) {
    //     print('error');
    //     print(e.message);
    //   }
    // }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ValueNotifier<Menu>>(
          create: (context) =>
              ValueNotifier<Menu>(Menu(index: 0, name: "Home", path: "home")),
        ),
      ],
      child: const AMResponsiveLayout(
        desktopWidget: AMScaffold(
          appBar: AppBarHome(),
          body: AppPageDesktop(),
        ),
      ),
    );
  }
}
