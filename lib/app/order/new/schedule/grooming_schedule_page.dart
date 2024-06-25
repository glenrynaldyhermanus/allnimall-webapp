import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/data/objects/grooming_schedule.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/button/allnimall_primary_button.dart';
import 'package:allnimall_web/src/ui/components/picker/allnimall_date_picker.dart';
import 'package:allnimall_web/src/ui/components/picker/allnimall_grooming_time_picker.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class GroomingSchedulePage extends StatefulWidget {
  const GroomingSchedulePage({Key? key}) : super(key: key);

  @override
  State<GroomingSchedulePage> createState() => _GroomingSchedulePageState();
}

class _GroomingSchedulePageState extends State<GroomingSchedulePage> {
  DateTime? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllnimallColors.backgroundPrimary,
      appBar: const AppBarCustomer(title: 'Jadwal Grooming'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    AllnimallDatePicker(onChanged: (val) {
                      selectedDate = val;
                    }),
                    AllnimallGroomingTimePicker(onChanged: (val) {
                      selectedTime = val;
                    }),
                  ].divide(const Gap(16)),
                ),
              ),
            ),
            AllnimallPrimaryButton(
              'Simpan',
              outsidePadding: const EdgeInsets.all(24),
              onPressed: () {
                if (selectedDate != null && selectedTime != null) {
                  context.pop(
                    GroomingSchedule(
                      date: selectedDate!,
                      time: selectedTime!,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
