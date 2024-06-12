import 'package:allnimall_web/src/ui/layouts/allnimall_scaffold.dart';
import 'package:flutter/material.dart';

class AMResponsiveLayout extends StatefulWidget {
  const AMResponsiveLayout({
    Key? key,
    this.mobileWidget,
    this.tabWidget,
    this.desktopWidget,
  }) : super(key: key);

  final AMScaffold? mobileWidget;
  final AMScaffold? tabWidget;
  final AMScaffold? desktopWidget;

  @override
  State<AMResponsiveLayout> createState() =>
      _AMResponsiveLayoutState();
}

class _AMResponsiveLayoutState extends State<AMResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget baseWidget = Container();
        if (widget.desktopWidget != null) {
          baseWidget = widget.desktopWidget!;
        } else if (widget.tabWidget != null) {
          baseWidget = widget.tabWidget!;
        } else if (widget.mobileWidget != null) {
          baseWidget = widget.mobileWidget!;
        }

        if (constraints.maxWidth < 600) {
          return Scaffold(
              body: widget.mobileWidget == null
                  ? baseWidget
                  : widget.mobileWidget!);
        } else if (constraints.maxWidth < 1200) {
          return Scaffold(
              body: widget.tabWidget == null ? baseWidget : widget.tabWidget!);
        } else {
          return Scaffold(
              body: widget.desktopWidget == null
                  ? baseWidget
                  : widget.desktopWidget!);
        }
      },
    );
  }
}
