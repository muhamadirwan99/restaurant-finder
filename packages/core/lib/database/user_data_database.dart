import 'package:core/core.dart';

class UserDataDatabase {
  static double lat = 0.0;
  static double lng = 0.0;

  static load() async {
    lat = mainStorage.get("lat") ?? 0.0;
    lng = mainStorage.get("lng") ?? 0.0;
  }

  static save(double lat, double lng) async {
    mainStorage.put("lat", lat);
    mainStorage.put("lng", lng);

    UserDataDatabase.lat = lat;
    UserDataDatabase.lng = lng;
  }
}
