import 'dart:convert';

import 'package:app2park/module/config/ParkUserResponse.dart';
import 'package:app2park/module/config/get_parkuser_response.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';

class ParkUserService{
  static Future<ParkUserResponse> getParks(String id, String jwt) async {
    try{
      final url = urlRequest+"api/puser/$id?jwt=$jwt";

      final response = await http.get(url);

      final s = response.body;

      final r = ParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<GetParkUserResponse> getPuser(String id_park, String id_user) async {
    try{
      final url = urlRequest+"api/puser/getallpuser/$id_park/$id_user";

      final response = await http.get(url);

      final s = response.body;

      final r = GetParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<GetParkUserResponse> getPuserActive(String id_park) async {
    try{
      final url = urlRequest+"api/puser/allinvitesactive/$id_park?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiNiJ9.KT1wqldO5xPwBfXKdGq3HILEF6nhrm4hc2enQreChTE";

      final response = await http.get(url);

      final s = response.body;

      final r = GetParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<GetParkUserResponse> getPuserPending(String id) async {
    try{
      final url = urlRequest+"api/puser/allinvitespending/$id?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiNiJ9.KT1wqldO5xPwBfXKdGq3HILEF6nhrm4hc2enQreChTE";

      final response = await http.get(url);

      final s = response.body;

      final r = GetParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<GetParkUserResponse> sincPuserOut(String id) async {
    try{
      final url = urlRequest+"api/puser/sincpuserout/$id?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiNiJ9.KT1wqldO5xPwBfXKdGq3HILEF6nhrm4hc2enQreChTE";


      final response = await http.get(url);

      final s = response.body;

      final r = GetParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<GetParkUserResponse> getPuserInactive(String id) async {
    try{
      final url = urlRequest+"api/puser/allinvitesinactive/$id?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiNiJ9.KT1wqldO5xPwBfXKdGq3HILEF6nhrm4hc2enQreChTE";

      final response = await http.get(url);

      final s = response.body;

      final r = GetParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<GetParkUserResponse> getallPuser(String id) async {
    try{
      final url = urlRequest+"api/puser/allinvites/$id?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiNiJ9.KT1wqldO5xPwBfXKdGq3HILEF6nhrm4hc2enQreChTE";


      final response = await http.get(url);

      final s = response.body;


      final r = GetParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<GetParkUserResponse>updatePuser(ParkUser parkUser) async {
    try{
      final url = urlRequest+"api/puser/updateinvite";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(parkUser.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = GetParkUserResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

}