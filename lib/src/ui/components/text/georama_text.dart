import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

class GeoramaText extends StatelessWidget {
  const GeoramaText(this.text, {
    Key? key,
    this.color = AllnimallColors.textPrimary,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.fontSize = 12.0,
  }) : super(key: key);

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextRenderer(
      child: Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: GoogleFonts.georama(
          textStyle: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
