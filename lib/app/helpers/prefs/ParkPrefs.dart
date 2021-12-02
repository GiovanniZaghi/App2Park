import 'dart:convert' as convert;
import 'package:app2park/app/helpers/prefs/Prefs.dart';
import 'package:app2park/module/park/Park.dart';

class ParkPrefs {
  static void clear() {
    Prefs.setString("park.prefs", "");
  }

  void save(Park park) {
    Map map = park.toJson();

    String json = convert.json.encode(map);

    Prefs.setString("park.prefs", json);
  }

  static Future<Park> get() async {
    String json = await Prefs.getString("park.prefs");
    if (json.isEmpty) {
      return null;
    }
    Map map = convert.json.decode(json);
    Park park = Park.fromJson(map);
    return park;
  }
}
