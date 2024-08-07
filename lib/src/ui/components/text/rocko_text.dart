import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

class RockoText extends StatelessWidget {
  const RockoText(
    this.text, {
    Key? key,
    this.color = AllnimallColors.textPrimary,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 12.0,
  }) : super(key: key);

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextRenderer(
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'RockoUltra',
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
