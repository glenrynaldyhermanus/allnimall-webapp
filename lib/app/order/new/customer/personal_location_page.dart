import 'dart:async';

import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/data/objects/personal_location.dart';
import 'package:allnimall_web/src/ui/components/appbar/appbar_customer.dart';
import 'package:allnimall_web/src/ui/components/button/allnimall_primary_button.dart';
import 'package:allnimall_web/src/ui/components/picker/allnimall_city_picker.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_place_autocomplete_textfield.dart';
import 'package:allnimall_web/src/ui/components/textfield/allnimall_textfield.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PersonalLocationPage extends StatefulWidget {
  const PersonalLocationPage({Key? key}) : super(key: key);

  @override
  State<PersonalLocationPage> createState() => _PersonalLocationPageState();
}

class _PersonalLocationPageState extends State<PersonalLocationPage> {
  LatLng? selectedLatLng;
  String? selectedAddress;
  String? selectedCity;
  String? notes;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  bool isCityAvailable() {
    if (selectedCity!.contains('Jakarta') || selectedCity!.contains('Depok')) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllnimallColors.backgroundPrimary,
      appBar: const AppBarCustomer(title: 'Lokasi'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    AllnimallPlaceAutoCompleteTextField(
                      'Alamat lengkap',
                      hint: 'Cari alamat',
                      autofocus: true,
                      onChanged: (value) async {
                        if (value != null) {
                          setState(() {
                            selectedAddress = value.split('||')[2];
                            selectedCity = value.split('||')[3];
                            selectedLatLng = LatLng(
                              double.parse(value.split('||')[0]),
                              double.parse(value.split('||')[1]),
                            );
                          });
                          final GoogleMapController controller =
                              await mapController.future;
                          await controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  bearing: 192.8334901395799,
                                  target: LatLng(
                                    double.parse(value.split('||')[0]),
                                    double.parse(value.split('||')[1]),
                                  ),
                                  tilt: 59.440717697143555,
                                  zoom: 19.151926040649414)));
                        }
                      },
                    ),
                    AllnimallTextField(
                      'Catatan',
                      hint: 'Detail lokasi, nomor / lantai unit / warna pagar',
                      onChanged: (value) {
                        if (value != null) {
                          notes = value;
                        }
                      },
                    ),
                    AllnimallCityPicker(
                      initialValue: selectedCity,
                      onChanged: (value) {
                        if (value != null) {
                          selectedCity = value;
                        }
                      },
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          GoogleMap(
                            mapType: MapType.normal,
                            zoomControlsEnabled: true,
                            rotateGesturesEnabled: false,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            tiltGesturesEnabled: false,
                            mapToolbarEnabled: false,
                            initialCameraPosition: const CameraPosition(
                              target:
                                  LatLng(-6.345571693636769, 106.8335550674784),
                              zoom: 18,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              mapController.complete(controller);
                            },
                            onCameraMove: (position) {
                              selectedLatLng = position.target;
                            },
                          ),
                          const Center(
                            child: Icon(
                              Icons.location_on_rounded,
                              color: AllnimallColors.secondary,
                              size: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].divide(const Gap(16)),
                ),
              ),
            ),
            if (selectedCity != null && isCityAvailable())
              AllnimallPrimaryButton(
                'Simpan',
                outsidePadding: const EdgeInsets.all(24),
                onPressed: () {
                  if (selectedLatLng != null && selectedAddress != null) {
                    context.pop(
                      PersonalLocation(
                        latLng: selectedLatLng!,
                        address: selectedAddress!,
                        city: selectedCity!,
                        notes: notes ?? '',
                      ),
                    );
                  }
                },
              ),
            if (selectedCity != null && !isCityAvailable())
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: GeoramaText(
                  'Groomer belum tersedia di kota kamu!',
                  fontSize: 16,
                  color: Colors.red,
                ),
              )
          ],
        ),
      ),
    );
  }
}
