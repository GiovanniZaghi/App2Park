import 'package:json_annotation/json_annotation.dart';

part 'price_helper.g.dart';

@JsonSerializable()
class PriceHelper{
  int id;
  int id_price_detached_item_app;
  int id_price_detached;
  int id_price_detached_app;
  int id_price_detached_item_base;
  double price;
  String tolerance;
  String name_table;
  String name;
  String time;
  String type;
  int level;

  PriceHelper(
      this.id,
      this.id_price_detached_item_app,
      this.id_price_detached,
      this.id_price_detached_app,
      this.id_price_detached_item_base,
      this.price,
      this.tolerance,
      this.name_table,
      this.name,
      this.time,
      this.type,
      this.level);

  factory PriceHelper.fromJson(Map<String, dynamic> json) => _$PriceHelperFromJson(json);

  Map<String, dynamic> toJson() => _$PriceHelperToJson(this);
}