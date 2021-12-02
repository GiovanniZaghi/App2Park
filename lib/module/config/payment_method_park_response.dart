import 'package:app2park/module/park/payments/payment_method_park_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method_park_response.g.dart';

@JsonSerializable()
class PaymentMethodParkResponse{
  String status;
  List<PaymentMethodParkModel> data;
  String message;

  PaymentMethodParkResponse({this.status, this.data, this.message});

  factory PaymentMethodParkResponse.fromJson(Map<String, dynamic> json) => _$PaymentMethodParkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodParkResponseToJson(this);

}