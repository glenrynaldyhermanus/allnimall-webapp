import 'package:shared_preferences/shared_preferences.dart';

class PrefKey {
  static const token = "token";
  static const refreshToken = "refreshToken";

  static const cart = "cart";
}

class AMPreferences {
  final SharedPreferences storage;

  AMPreferences(this.storage);

  void writeData(String key, String value) {
    storage.setString(key, value);
  }

  String? readData(String key) {
    var readData = storage.getString(key);
    return readData;
  }

  void deleteSecureData(String key) {
    storage.remove(key);
  }
}
