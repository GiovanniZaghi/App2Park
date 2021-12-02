import 'dart:convert' as convert;
import 'package:app2park/app/helpers/prefs/Prefs.dart';
import 'package:app2park/module/user/User.dart';

class UserPrefs {
  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save(User user) {
    Map map = user.toJson();

    String json = convert.json.encode(map);

    Prefs.setString("user.prefs", json);
  }

  static Future<User> get() async {
    String json = await Prefs.getString("user.prefs");
    if (json.isEmpty) {
      return null;
    }
    Map map = convert.json.decode(json);
    User user = User.fromJson(map);
    return user;
  }
}
