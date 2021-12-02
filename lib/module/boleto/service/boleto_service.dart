import 'dart:convert';
import 'package:app2park/module/boleto/boleto.dart';
import 'package:app2park/module/boleto/send_mail_boleto.dart';
import 'package:app2park/module/config/boleto_response.dart';
import 'package:app2park/module/config/send_mail_boleto_response.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';

class BoletoService{
  static Future<BoletoResponse> createBoleto(Boleto boleto) async {
    try {
      final url = urlRequest+"api/boleto/newboleto";
      print("> post: $url");

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(boleto.toJson());
      print("   > $body");

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;
      print("   < $s");

      final r = BoletoResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
      print("Error > $e");
    }
  }

  static Future<SendMailBoletoResponse> sendMailBoleto(SendMailBoleto boleto) async {
    try {
      final url = urlRequest+"api/boleto/sendboleto";
      print("> post: $url");

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(boleto.toJson());
      print("   > $body");

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;
      print("   < $s");

      final r = SendMailBoletoResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
      print("Error > $e");
    }
  }
}