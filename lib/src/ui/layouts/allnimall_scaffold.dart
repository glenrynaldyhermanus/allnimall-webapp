import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';

class AMScaffold extends StatefulWidget {
  const AMScaffold(
      {Key? key, this.appBar, this.body = const SizedBox.expand()})
      : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget body;

  @override
  State<AMScaffold> createState() => _AMScaffoldState();
}

class _AMScaffoldState extends State<AMScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
      backgroundColor: AllnimallColors.backgroundPrimary,
    );
  }
}
