import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';

class AllnimallPlaceAutoCompleteTextField extends StatefulWidget {
  final String label;
  final bool enabled;
  final String? hint;
  final String? errorMessage;
  final Function(String? val) onChanged;
  final bool autofocus;

  const AllnimallPlaceAutoCompleteTextField(
    this.label, {
    super.key,
    this.hint,
    this.enabled = true,
    this.autofocus = false,
    this.errorMessage,
    required this.onChanged,
  });

  @override
  State<AllnimallPlaceAutoCompleteTextField> createState() =>
      _AllnimallPlaceAutoCompleteTextFieldState();
}

class _AllnimallPlaceAutoCompleteTextFieldState
    extends State<AllnimallPlaceAutoCompleteTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

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
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
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
              GooglePlacesAutoCompleteTextFormField(
                textEditingController: _controller,
                googleAPIKey: "AIzaSyD7h4O0BJAxeW31pG88Kr3mknke8KEZ7r4",
                proxyURL: "http://cors-anywhere.herokuapp.com/",
                debounceTime: 400,
                countries: const ["id"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (prediction) {
                  widget.onChanged('${prediction.lat}||${prediction.lng}||${prediction.description}');
                },
                itmClick: (prediction) {
                  _controller.text = prediction.description!;
                  _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: prediction.description!.length));
                },
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                focusNode: _focusNode,
                cursorColor: AllnimallColors.primary,
                style: GoogleFonts.georama(
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
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
