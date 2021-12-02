import 'package:json_annotation/json_annotation.dart';

part 'price_detached_item_model.g.dart';

@JsonSerializable()
class PriceDetachedItem{
  String id;
  String id_price_detached_item_app;
  String id_price_detached;
  String id_price_detached_item_base;
  String price;
  String tolerance;


  PriceDetachedItem({
      this.id,
      this.id_price_detached_item_app,
      this.id_price_detached,
      this.id_price_detached_item_base,
      this.price,
      this.tolerance});

  factory PriceDetachedItem.fromJson(Map<String, dynamic> json) =>
      _$PriceDetachedItemFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedItemToJson(this);
}