import 'dart:async';

import 'package:app2park/app/helpers/prefs/Prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwtPrefs {
  static void clear() {
    Prefs.setString("jwt.prefs", "");
  }

  void save(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt.prefs', jwt);
  }

  static Future<String> get() async {
    final prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('jwt.prefs') ?? '';
    return stringValue;
  }
}
