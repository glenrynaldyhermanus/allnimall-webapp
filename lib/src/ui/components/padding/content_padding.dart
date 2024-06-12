import 'package:allnimall_web/src/ui/res/dimensions.dart';
import 'package:flutter/cupertino.dart';

class ContentPadding extends StatelessWidget {
  const ContentPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AMDimens.kdContentPadding,
          right: AMDimens.kdContentPadding),
      child: child,
    );
  }
}
