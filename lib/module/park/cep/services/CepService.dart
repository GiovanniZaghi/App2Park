import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Cep.dart';

class CepService{

  static Future<Cep> getCEP(String cep) async {
    try{
      final url = "https://viacep.com.br/ws/$cep/json/";

      final response = await http.get(url);

      final s = response.body;

      final r = Cep.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }
}