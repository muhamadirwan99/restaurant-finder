import 'package:core/core.dart';

class UserDataDatabase {
  static double lat = 0.0;
  static double lng = 0.0;
  static String username = '';
  static String email = '';

  static load() async {
    lat = mainStorage.get("lat") ?? 0.0;
    lng = mainStorage.get("lng") ?? 0.0;
    username = mainStorage.get("username") ?? '';
    email = mainStorage.get("email") ?? '';
  }

  static save(double lat, double lng) async {
    mainStorage.put("lat", lat);
    mainStorage.put("lng", lng);

    UserDataDatabase.lat = lat;
    UserDataDatabase.lng = lng;
  }

  static saveUserData(String username, String email) async {
    mainStorage.put("username", username);
    mainStorage.put("email", email);

    UserDataDatabase.username = username;
    UserDataDatabase.email = email;
  }
}
