import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/data/objects/personal_location.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AllnimallLocationPicker extends StatefulWidget {
  final String? errorMessage;
  final Function(PersonalLocation val) onPicked;

  const AllnimallLocationPicker({
    super.key,
    this.errorMessage,
    required this.onPicked,
  });

  @override
  State<AllnimallLocationPicker> createState() =>
      _AllnimallLocationPickerState();
}

class _AllnimallLocationPickerState extends State<AllnimallLocationPicker> {
  final FocusNode _focusNode = FocusNode();
  var selectedAddress = "";
  var notes = "";

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
            context.pushNamed('customerLocation').then(
              (value) {
                if (value != null && value is PersonalLocation) {
                  widget.onPicked(value);
                  setState(() {
                    selectedAddress = value.address;
                    notes = value.notes;
                  });
                }
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 6),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isError() ? Colors.red : Colors.black26, width: 1),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200]!),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GeoramaText(
                        'Alamat lengkap',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      const Gap(8),
                      GeoramaText(
                        selectedAddress.isEmpty
                            ? 'Cari alamat'
                            : '$selectedAddress. $notes',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: selectedAddress.isEmpty
                            ? Colors.grey[500]!
                            : AllnimallColors.textPrimary,
                      )
                    ],
                  ),
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
