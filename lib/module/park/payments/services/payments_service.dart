import 'package:app2park/module/config/payment_method_park_response.dart';
import 'package:app2park/module/config/payment_method_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../config_dev.dart';

class PaymentService{

  static Future<PaymentMethodResponse> getPaymentMethod() async {
    try{
      final url = urlRequest+"api/payments/paymentsallmethod";

      final response = await http.get(url);

      final s = response.body;

      final r = PaymentMethodResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<PaymentMethodParkResponse> getPaymentMethodPark(String id_park) async {
    try{
      final url = urlRequest+"api/payments/allpaymentsmethodbypark/$id_park";

      final response = await http.get(url);

      final s = response.body;

      final r = PaymentMethodParkResponse.fromJson(json.decode(s));

      return r;
    } catch(e){
    }

  }

  static Future<PaymentMethodParkResponse> SincPaymentMethodPark(String id_park) async {
    try{
      final url = urlRequest+"api/payments/sincpaymentmethodparkbyidpark/$id_park";

      final response = await http.get(url);

      final s = response.body;

      final r = PaymentMethodParkResponse.fromJson(json.decode(s));

      return r;
    } catch(e){

    }

  }
}