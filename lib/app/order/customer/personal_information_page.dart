import 'dart:async';

import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/button/allnimall_primary_button.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_phone_textfield.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_place_autocomplete_textfield.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_textfield.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  LatLng? latLng;
  var selectedCity = '';
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

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
                    AllnimallPhoneTextField('No Handphone',
                        hint: '8XX-XXXX-XXXX', onChanged: (value) {}),
                    // AllnimallOtpTextField('Kode OTP',
                    //     hint: '* * * * * *', onChanged: (value) {})
                    AllnimallTextField('Nama lengkap',
                        hint: 'Ketik nama lengkap', onChanged: (value) {}),
                    const Gap(16),
                    const GeoramaText(
                      'Lokasi pemesanan',
                      fontSize: 16,
                    ),
                    AllnimallPlaceAutoCompleteTextField(
                      'Alamat lengkap',
                      hint: 'Cari alamat',
                      onChanged: (value) async {
                        if (value != null) {
                          setState(() {
                            latLng = LatLng(
                              double.parse(value.split(',')[0]),
                              double.parse(value.split(',')[1]),
                            );
                          });
                          // final GoogleMapController controller =
                          //     await mapController.future;
                          // await controller.animateCamera(
                          //     CameraUpdate.newCameraPosition(CameraPosition(
                          //         bearing: 192.8334901395799,
                          //         target: LatLng(
                          //           double.parse(value.split(',')[0]),
                          //           double.parse(value.split(',')[1]),
                          //         ),
                          //         tilt: 59.440717697143555,
                          //         zoom: 19.151926040649414)));
                        }
                      },
                    ),
                    AllnimallTextField(
                      'Catatan',
                      hint: 'Nomor / lantai unit',
                      onChanged: (value) {},
                    ),

                    if (latLng != null)
                      StaticMap(
                        googleApiKey: "AIzaSyD7h4O0BJAxeW31pG88Kr3mknke8KEZ7r4",
                        width: double.infinity,
                        height: 200,
                        zoom: 10,
                        center: GeocodedLocation.latLng(
                            latLng!.latitude, latLng!.longitude),
                      ),
                    // SizedBox(
                    //   height: 200,
                    //   width: double.infinity,
                    //   child: Stack(
                    //     children: [
                    //
                    //
                    //
                    //       GoogleMap(
                    //         mapType: MapType.normal,
                    //         zoomControlsEnabled: true,
                    //         rotateGesturesEnabled: false,
                    //         scrollGesturesEnabled: false,
                    //         zoomGesturesEnabled: false,
                    //         tiltGesturesEnabled: false,
                    //         mapToolbarEnabled: false,
                    //         initialCameraPosition: const CameraPosition(
                    //           target: LatLng(
                    //               -6.345571693636769, 106.8335550674784),
                    //           zoom: 18,
                    //         ),
                    //         onMapCreated: (GoogleMapController controller) {
                    //           mapController.complete(controller);
                    //         },
                    //       ),
                    //       Positioned(
                    //         top: 100 - 36,
                    //         left: (MediaQuery.of(context).size.width / 2) - 48,
                    //         child: const Icon(
                    //           Icons.location_on_rounded,
                    //           color: AllnimallColors.secondary,
                    //           size: 36,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // AllnimallCityPicker(onChanged: (value) {
                    //   setState(() {
                    //     selectedCity = value!;
                    //   });
                    // }),
                    // AllnimallDistrictPicker(
                    //     city: selectedCity, onChanged: (value) {}),
                    // AllnimallTextField('Alamat lengkap',
                    //     hint: 'Ketik alamat lengkap', onChanged: (value) {}),
                  ].divide(const Gap(16)),
                ),
              ),
            ),
            const AllnimallPrimaryButton(
              'Simpan',
              outsidePadding: EdgeInsets.all(24),
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
