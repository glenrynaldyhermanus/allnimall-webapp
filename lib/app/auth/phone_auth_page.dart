import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/button/allnimall_primary_button.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_otp_textfield.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_phone_textfield.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  String? phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllnimallColors.backgroundPrimary,
      appBar: const AppBarCustomer(title: 'Verifikasi Pengguna'),
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
                    AllnimallOtpTextField('Kode OTP', onChanged: (value) {}),
                  ].divide(const Gap(16)),
                ),
              ),
            ),
            AllnimallPrimaryButton(
              'Verifikasi',
              outsidePadding: const EdgeInsets.all(24),
              onPressed: () {
                if (phone != null) {
                  context.pop();
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
