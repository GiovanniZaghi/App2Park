import 'dart:convert';
import 'package:app2park/module/cart/cart_item_model.dart';
import 'package:app2park/module/cart/cart_model.dart';
import 'package:app2park/module/config/cart_item_response.dart';
import 'package:app2park/module/config/cart_response.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';

class CartService{
  static Future<CartResponse> createCart(CartModel cartModel) async {
    try {
      final url = urlRequest+"api/cart/newcart";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(cartModel.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = CartResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<CartItemResponse> createCartItem(CartItemModel cartItemModel) async {
    try {
      final url = urlRequest+"api/cart/newcartitem";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(cartItemModel.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = CartItemResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }
}