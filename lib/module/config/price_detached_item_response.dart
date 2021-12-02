import 'package:app2park/module/payment/priceitem/price_detached_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_detached_item_response.g.dart';

@JsonSerializable()
class PriceDetachedItemResponse{
  String status;
  List<PriceDetachedItem> data;
  String message;

  PriceDetachedItemResponse({this.status, this.data, this.message});

  factory PriceDetachedItemResponse.fromJson(Map<String, dynamic> json) => _$PriceDetachedItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedItemResponseToJson(this);

}