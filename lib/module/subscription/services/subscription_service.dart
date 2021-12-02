import 'dart:convert';
import 'package:app2park/module/config/subscription_item_response.dart';
import 'package:app2park/module/config/subscription_response.dart';
import 'package:app2park/module/subscription/subscription_item_model.dart';
import 'package:app2park/module/subscription/subscription_model.dart';
import 'package:http/http.dart' as http;

import '../../../config_dev.dart';

class SubscriptionService{
  static Future<SubscriptionResponse> createSubscription(SubscriptionModel subscriptionModel) async {
    try {
      final url = urlRequest+"api/subscription/newsubcription";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(subscriptionModel.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = SubscriptionResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }

  static Future<SubscriptionItemResponse> createSubscriptionItem(SubscriptionItemModel subscriptionItemModel) async {
    try {
      final url = urlRequest+"api/subscription/newsubcriptionitem";

      final headers = {"Content-Type": "application/json"};
      final body = json.encode(subscriptionItemModel.toJson());

      final response = await http.post(url, headers: headers, body: body);

      final s = response.body;

      final r = SubscriptionItemResponse.fromJson(json.decode(s));

      return r;
    } catch (e) {
    }
  }
}