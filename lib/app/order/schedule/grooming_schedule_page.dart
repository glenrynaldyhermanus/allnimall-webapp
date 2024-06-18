import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/picker/allnimall_city_picker.dart';
import 'package:allnimall_web/src/ui/components/picker/allnimall_date_picker.dart';
import 'package:allnimall_web/src/ui/components/picker/allnimall_grooming_time_picker.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GroomingSchedulePage extends StatefulWidget {
  const GroomingSchedulePage({Key? key}) : super(key: key);

  @override
  State<GroomingSchedulePage> createState() => _GroomingSchedulePageState();
}

class _GroomingSchedulePageState extends State<GroomingSchedulePage> {
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
                    AllnimallDatePicker(onChanged: (val) {}),
                    AllnimallGroomingTimePicker(onChanged: (val) {}),
                  ].divide(const Gap(16)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
