import 'package:app2park/module/payment/price/price_detached_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_detached_response.g.dart';

@JsonSerializable()
class PriceDetachedResponse{
  String status;
  List<PriceDetached> data;
  String message;

  PriceDetachedResponse({this.status, this.data, this.message});

  factory PriceDetachedResponse.fromJson(Map<String, dynamic> json) => _$PriceDetachedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedResponseToJson(this);

}