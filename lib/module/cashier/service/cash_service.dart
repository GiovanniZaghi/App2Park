import 'dart:convert';
import 'package:app2park/module/cashier/cashs_model.dart';
import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:app2park/module/config/cash_movement_response.dart';
import 'package:app2park/module/config/cash_response.dart';
import 'package:app2park/module/config/cash_type_response.dart';
import 'package:app2park/module/sinc_model.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';

class CashTypeService{
  static Future<CashTypeResponse> getCashs() async {
    try {
      final url = urlRequest+"api/cashs/allcashmovementtype";

      final response = await http.get(url);

      final s = response.body;

      final r = CashTypeResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<CashMovementResponse> cashMovement(CashMovement cashMovement) async {
    try{
      final url = urlRequest+"api/cashs/newcashmovement";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(cashMovement.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = CashMovementResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<CashResponse> cash(Cashs cashs) async {
    try{
      final url = urlRequest+"api/cashs/newcash";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(cashs.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = CashResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<CashResponse> cashSinc(SincModel sincModel) async {
    try{
      final url = urlRequest+"api/cashs/sinccashs";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(sincModel.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = CashResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<CashMovementResponse> getTicketInfoSinc(String id_cash) async {
    try{
      final url = urlRequest+"api/cashs/cashmovementtype/$id_cash";

      final response = await http.get(url);

      final s = response.body;

      final r = CashMovementResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }
}
