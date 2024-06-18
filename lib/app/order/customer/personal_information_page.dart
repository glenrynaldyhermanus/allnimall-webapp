import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/data/objects/personal_information.dart';
import 'package:allnimall_web/src/data/objects/personal_location.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/button/allnimall_primary_button.dart';
import 'package:allnimall_web/src/ui/components/picker/allnimall_location_picker.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_phone_textfield.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_textfield.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  String? name;
  String? phone;
  PersonalLocation? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllnimallColors.backgroundPrimary,
      appBar: const AppBarCustomer(title: 'Informasi Personal'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  children: [
                    const IntroRow(),
                    AllnimallPhoneTextField(
                      'No Handphone',
                      hint: '8XX-XXXX-XXXX',
                      onChanged: (value) {
                        phone = value;
                      },
                    ),
                    AllnimallTextField(
                      'Nama lengkap',
                      hint: 'Ketik nama lengkap',
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    const Gap(16),
                    const GeoramaText(
                      'Lokasi pemesanan',
                      fontSize: 16,
                    ),
                    AllnimallLocationPicker(
                      onPicked: (value) {
                        location = value;
                      },
                    ),
                  ].divide(const Gap(16)),
                ),
              ),
            ),
            AllnimallPrimaryButton(
              'Simpan',
              outsidePadding: const EdgeInsets.all(24),
              onPressed: () {
                if (name != null && phone != null && location != null) {
                  context.pop(
                    PersonalInformation(
                        name: name!, phone: phone!, location: location!),
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

class IntroRow extends StatelessWidget {
  const IntroRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeoramaText(
          'Hai Allnimall Lovers!',
          fontSize: 20,
        ),
        GeoramaText(
          'Mohon masukkan data yang valid, agar tidak ada kesalahan dalam pemesanan jasa',
          fontSize: 12,
        ),
      ],
    );
  }
}
