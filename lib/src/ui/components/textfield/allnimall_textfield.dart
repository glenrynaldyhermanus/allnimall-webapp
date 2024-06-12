import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AllnimallTextField extends StatefulWidget {
  final String label;
  final bool obsecureText;
  final bool? enabled;
  final String? hint;
  final String? errorMessage;
  final TextEditingController? controller;
  final Function(String? val) onChanged;
  final TextInputType inputType;

  const AllnimallTextField(
    this.label, {
    super.key,
    this.hint,
    this.obsecureText = false,
    this.enabled = true,
    this.errorMessage,
    this.controller,
    this.inputType = TextInputType.text,
    required this.onChanged,
  });

  @override
  State<AllnimallTextField> createState() => _AllnimallTextFieldState();
}

class _AllnimallTextFieldState extends State<AllnimallTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => {});
    });
  }

  bool isError() {
    if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 12),
          decoration: BoxDecoration(
              border: Border.all(
                  color: isError() ? Colors.red : Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: widget.enabled == true
                  ? Colors.grey[200]!
                  : Colors.grey[600]!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeoramaText(
                widget.label,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              const Gap(8),
              TextFormField(
                controller: widget.controller,
                onChanged: widget.onChanged,
                enabled: widget.enabled,
                autofocus: false,
                focusNode: _focusNode,
                keyboardType: widget.inputType,
                obscureText: widget.obsecureText,
                cursorColor: AllnimallColors.primary,
                style: GoogleFonts.georama(
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                      fontSize: 16, color: Colors.grey[500]),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  fillColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
        if (isError())
          GeoramaText(
            isError() ? widget.errorMessage! : '',
            color: Colors.red,
          )
      ].divide(const SizedBox(height: 4)),
    );
  }
}
