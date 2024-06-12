import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

class TextSectionTitle extends StatelessWidget {
  const TextSectionTitle(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextRenderer(
      child: Text(text,
          style: const TextStyle(
            fontFamily: 'RockoUltra',
            color: AllnimallColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 24.0,
          )),
    );
  }
}
