import 'package:google_maps_flutter/google_maps_flutter.dart';

class PersonalLocation {
  LatLng latLng;
  String address;
  String notes;

  PersonalLocation({
    required this.latLng,
    required this.address,
    required this.notes,
  });
}
