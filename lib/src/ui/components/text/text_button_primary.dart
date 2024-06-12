import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';

class TextButtonPrimary extends StatelessWidget {
  const TextButtonPrimary(this.text,
      {Key? key, this.isSelected, this.fontSize = 16})
      : super(key: key);
  final String text;
  final bool? isSelected;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Color textColor = AllnimallColors.primary;
    if (isSelected != null) {
      if (isSelected!) {
        textColor = AllnimallColors.secondary;
      } else {
        textColor = AllnimallColors.textSecondary;
      }
    }

    return Text(
      text,
      style: TextStyle(
        fontFamily: 'RockoUltra',
        color: textColor,
        fontSize: fontSize,
      ),
    );
  }
}
