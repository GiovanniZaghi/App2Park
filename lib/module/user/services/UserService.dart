import 'dart:convert';
import 'package:app2park/module/config/UserForgotResponse.dart';
import 'package:app2park/module/config/UserRecoverResponse.dart';
import 'package:app2park/module/config/UserResponse.dart';
import 'package:app2park/module/config/UserResponseChange.dart';
import 'package:app2park/module/user/recover/RecoverEmail.dart';
import 'package:app2park/module/user/userjwt/UserJwt.dart';
import 'package:http/http.dart' as http;
import 'package:app2park/module/user/User.dart';

import '../../../config_dev.dart';

class UserService {
  static Future<UserResponse> login(User user) async {
    try {
      final url = urlRequest+"api/users/login";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(user.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = UserResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<UserResponse> save(User user) async {
    try {
      final url = urlRequest+"api/users/new";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(user.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = UserResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<UserResponseChange> change(UserJwt userjwt, String id) async {
    try {
      final url = urlRequest+"api/users/$id";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(userjwt.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = UserResponseChange.fromJson(json.decode(s));


      return r;
    } catch (e) {
    }
  }

  static Future<UserForgotResponse> recover(RecoverEmail res) async{
    try {
      final url = urlRequest+"api/users/pass";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(res.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = UserForgotResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }

  }

  static Future<UserRecoverResponse> recoverkey (RecoverEmail res) async{
    try {
      final url = urlRequest+"api/users/pass_new";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(res.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = UserRecoverResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {

    }

  }

  static Future<UserResponse> getUser(String id_user) async {
    try {
      final url = urlRequest+"api/users/$id_user?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiMSJ9.zWu-2dZEJSic1enji5CFoeSDr8Cbpc7KkRBK1ezPKwo";

      final response = await http.get(url);

      final s = response.body;

      final r = UserResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

}
