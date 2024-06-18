import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/bottomsheet/grooming_time_selection_sheet.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AllnimallGroomingTimePicker extends StatefulWidget {
  final String? errorMessage;
  final Function(String? val) onChanged;

  const AllnimallGroomingTimePicker({
    super.key,
    this.errorMessage,
    required this.onChanged,
  });

  @override
  State<AllnimallGroomingTimePicker> createState() =>
      _AllnimallGroomingTimePickerState();
}

class _AllnimallGroomingTimePickerState
    extends State<AllnimallGroomingTimePicker> {
  final FocusNode _focusNode = FocusNode();
  var selectedTime = "";

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
        InkWell(
          onTap: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: true,
              context: context,
              builder: (bottomSheetContext) {
                return const GroomingTimeSelectionSheet();
              },
            ).then((value) {
              if (value != null) {
                widget.onChanged(value);
                setState(() {
                  selectedTime = value;
                });
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isError() ? Colors.red : Colors.black26, width: 1),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200]!),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GeoramaText(
                      'Waktu grooming',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    const Gap(8),
                    GeoramaText(
                      selectedTime.isEmpty ? 'Pilih waktu' : selectedTime,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: selectedTime.isEmpty
                          ? Colors.grey[500]!
                          : AllnimallColors.textPrimary,
                    )
                  ],
                ),
              ],
            ),
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
