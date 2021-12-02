import 'package:app2park/app/helpers/prefs/Prefs.dart';

class Token {
  static void clear() {
    Prefs.setString("token ", "");
  }

  void save(String value) async {
    Prefs.setString("token ", value);
  }

  static Future<String> get() async {
    String token = await Prefs.getString("token ");
    return token;
  }
}
