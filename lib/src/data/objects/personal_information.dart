import 'package:allnimall_web/src/data/objects/personal_location.dart';

class PersonalInformation {
  String name;
  String phone;
  PersonalLocation location;

  PersonalInformation({
    required this.name,
    required this.phone,
    required this.location,
  });
}
