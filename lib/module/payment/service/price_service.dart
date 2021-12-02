import 'dart:convert';
import 'package:app2park/module/config/price_detached_item_response.dart';
import 'package:app2park/module/config/price_detached_response.dart';
import 'package:app2park/module/config/price_detached_sinc_response.dart';
import 'package:app2park/module/config/simple_response.dart';
import 'package:app2park/module/payment/price/price_detached_model.dart';
import 'package:app2park/module/payment/priceitem/price_detached_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:app2park/module/config/price_item_base_response.dart';

import '../../../config_dev.dart';


class PriceService{
  static Future<PriceItemBaseResponse> getAllPriceItemBase() async {
    try{
      final url = urlRequest+"api/prices/getallpricesitembase";

      final response = await http.get(url);

      final s = response.body;

      final r = PriceItemBaseResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedResponse> getAllPricesDetachedByPark(String id_park) async {
    try{
      final url = urlRequest+"api/prices/getpricedetached/$id_park";

      final response = await http.get(url);

      final s = response.body;

      final r = PriceDetachedResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedItemResponse> getAllPricesDetachedByIdDetached(String detached) async {
    try{
      final url = urlRequest+"api/prices/getpricedetacheditem/$detached";

      final response = await http.get(url);

      final s = response.body;

      final r = PriceDetachedItemResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedResponse> insertPriceDetached(PriceDetached priceDetached) async {
    try{
      final url = urlRequest+"api/prices/newpricedetached";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(priceDetached.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = PriceDetachedResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedItemResponse> insertPriceDetachedItem(PriceDetachedItem priceDetachedItem) async {
    try{
      final url = urlRequest+"api/prices/newpricedetacheditem";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(priceDetachedItem.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = PriceDetachedItemResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedItemResponse>updatePriceDetachedItem (String id, PriceDetachedItem priceDetachedItem) async {
    try{
      final url = urlRequest+"api/prices/updatepricedetacheditem/$id";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(priceDetachedItem.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = PriceDetachedItemResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedResponse>updatePriceDetached (String id, PriceDetached priceDetached) async {
    try{
      final url = urlRequest+"api/prices/updatepricedetached/$id";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(priceDetached.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = PriceDetachedResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<SimpleResponse> deletePriceDetachedItem(PriceDetachedItem priceDetachedItem) async {
    try{
      final url = urlRequest+"api/prices/deletepricedetacheditem";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(priceDetachedItem.toJson());


      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = SimpleResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedSincResponse> sincPriceDetached(PriceDetached priceDetached, String id) async {
    try{
      final url = urlRequest+"api/prices/sincpricedetached/$id";

      final headers = {"Content-Type":"application/json"};
      final body = json.encode(priceDetached.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = PriceDetachedSincResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }

  static Future<PriceDetachedItemResponse> sincGetPriceDetachedItem(String id) async {
    try{
      final url = urlRequest+"api/prices/sincgetpricedetacheditem/$id";


      final response = await http.get(url);

      final s = response.body;

      final r = PriceDetachedItemResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }
  }
}