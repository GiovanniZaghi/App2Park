import 'dart:convert';
import 'package:app2park/config_dev.dart';
import 'package:http/http.dart' as http;
import 'package:app2park/module/config/receipt_response.dart';
import 'package:app2park/module/receipt/receipt.dart';

class ReceiptService{
  static Future<ReceiptResponse> CriarRecibo(Receipt receipt) async {
    try {
      final url = urlRequest+"api/receipt/criarrecibo";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(receipt.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = ReceiptResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

}