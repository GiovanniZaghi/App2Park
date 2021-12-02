import 'package:app2park/module/park/payments/payment_method_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method_response.g.dart';

@JsonSerializable()
class PaymentMethodResponse{
  String status;
  List<PaymentMethodModel> data;
  String message;

  PaymentMethodResponse({this.status, this.data, this.message});

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) => _$PaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodResponseToJson(this);

}