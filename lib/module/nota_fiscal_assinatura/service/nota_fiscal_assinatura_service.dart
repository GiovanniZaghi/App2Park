import 'dart:convert';
import 'package:app2park/module/config/nota_fiscal_assinatura_response.dart';
import 'package:app2park/module/nota_fiscal_assinatura/nota_fiscal_assinatura_model.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';

class NotaFiscalAssinaturaService{
  static Future<NotaFiscalAssinaturaResponse> createNotaFiscal(NotaFiscalAssinaturaModel notaFiscalAssinaturaModel) async {
    try {
      final url = urlRequest+"api/notafiscalassinatura/newnotafiscalassinatura";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(notaFiscalAssinaturaModel.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = NotaFiscalAssinaturaResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }
}