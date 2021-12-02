import 'dart:convert';
import 'package:app2park/module/config/service_additional_response.dart';
import 'package:http/http.dart' as http;

import '../config_dev.dart';
class ServiceAdditionalService{
  static Future<ServiceAdditionalResponse> getServiceAdditional() async {
    try {
      final url = urlRequest+"api/services/getservicesadditional";
      print("> get: $url");

      final response = await http.get(url);

      final s = response.body;
      print("   < $s");

      final r = ServiceAdditionalResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
      print("Error > $e");
    }
  }
}