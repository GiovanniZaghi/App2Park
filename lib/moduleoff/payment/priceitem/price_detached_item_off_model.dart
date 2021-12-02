import 'package:json_annotation/json_annotation.dart';

part 'price_detached_item_off_model.g.dart';

@JsonSerializable()
class PriceDetachedItemOff{
  int id;
  int id_price_detached_item_app;
  int id_price_detached;
  int id_price_detached_app;
  int id_price_detached_item_base;
  double price;
  String tolerance;


  PriceDetachedItemOff(
      this.id,
      this.id_price_detached,
      this.id_price_detached_app,
      this.id_price_detached_item_base,
      this.price,
      this.tolerance);

  factory PriceDetachedItemOff.fromJson(Map<String, dynamic> json) =>
      _$PriceDetachedItemOffFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedItemOffToJson(this);
}