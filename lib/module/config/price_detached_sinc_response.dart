import 'package:app2park/module/payment/price/price_detached_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_detached_sinc_response.g.dart';

@JsonSerializable()
class PriceDetachedSincResponse{
  String status;
  List<PriceDetached> data;
  String message;
  String mode;

  PriceDetachedSincResponse({this.status, this.data, this.message, this.mode});

  factory PriceDetachedSincResponse.fromJson(Map<String, dynamic> json) => _$PriceDetachedSincResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedSincResponseToJson(this);

}