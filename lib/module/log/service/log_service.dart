import 'dart:convert';
import 'package:app2park/config_dev.dart';
import 'package:app2park/module/log/log.dart';
import 'package:app2park/module/log/response/log_response.dart';
import 'package:http/http.dart' as http;

class LogService{
  static Future<LogResponse> CriarLog(Log log) async {
    try {
      final url = urlRequest+"api/log/criarlog";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(log.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = LogResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

}