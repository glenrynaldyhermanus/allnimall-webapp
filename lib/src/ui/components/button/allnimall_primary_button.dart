import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';

class AllnimallPrimaryButton extends StatefulWidget {
  const AllnimallPrimaryButton(
    this.text, {
    Key? key,
    this.outsidePadding = EdgeInsets.zero,
    this.height = 44,
    this.width = double.infinity,
    this.radius = 8,
  }) : super(key: key);

  final EdgeInsets outsidePadding;
  final double height;
  final double width;
  final double radius;
  final String text;

  @override
  State<AllnimallPrimaryButton> createState() => _AllnimallPrimaryButtonState();
}

class _AllnimallPrimaryButtonState extends State<AllnimallPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outsidePadding,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: AllnimallColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
          child: GeoramaText(
            widget.text,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
