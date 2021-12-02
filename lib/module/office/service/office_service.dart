import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app2park/module/config/office_response.dart';

import '../../../config_dev.dart';

class OfficeService {
  static Future<OfficeResponse> getOffice() async {
    try {
      final url = urlRequest+"api/offices/getoffices";

      final response = await http.get(url);

      final s = response.body;

      final r = OfficeResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }
}
