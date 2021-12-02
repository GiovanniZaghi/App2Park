import 'package:app2park/module/park/vehicle/vehicle_type_park_model.dart';
import 'package:app2park/module/payment/priceitembase/price_detached_item_base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_item_base_response.g.dart';

@JsonSerializable()
class PriceItemBaseResponse{
  String status;
  List<PriceDetachedBase> data;
  String message;

  PriceItemBaseResponse({this.status, this.data, this.message});

  factory PriceItemBaseResponse.fromJson(Map<String, dynamic> json) => _$PriceItemBaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceItemBaseResponseToJson(this);

}