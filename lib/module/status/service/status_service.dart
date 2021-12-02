import 'dart:convert';
import 'package:app2park/module/config/status_response.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';


class StatusService {
  static Future<StatusResponse> getStatus() async {
    try {
      final url = urlRequest+"api/status/getstatus";

      final response = await http.get(url);

      final s = response.body;

      final r = StatusResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }
}
