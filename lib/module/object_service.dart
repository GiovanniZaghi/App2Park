import 'dart:convert';
import 'package:app2park/module/config/objects_response.dart';
import 'package:http/http.dart' as http;

import '../config_dev.dart';
class ObjectService{
  static Future<ObjectsResponse> getObjects() async {
    try {
      final url = urlRequest+"api/objects/getallobjects";
      print("> get: $url");

      final response = await http.get(url);

      final s = response.body;
      print("   < $s");

      final r = ObjectsResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
      print("Error > $e");
    }
  }
}