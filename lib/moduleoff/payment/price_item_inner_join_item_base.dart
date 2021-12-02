import 'package:json_annotation/json_annotation.dart';

part 'price_item_inner_join_item_base.g.dart';

@JsonSerializable()

class PriceItemInnerJoinBase{
  int id_price_detached_item_app;
  int id;
  String name;
  double price;
  String tolerance;
  int tickado;
  String type;
  int level;

  PriceItemInnerJoinBase(this.id_price_detached_item_app,
      this.id, this.name, this.price, this.tolerance, this.tickado, this.type, this.level);

  factory PriceItemInnerJoinBase.fromJson(Map<String, dynamic> json) =>
      _$PriceItemInnerJoinBaseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceItemInnerJoinBaseToJson(this);

  @override
  String toString() {
    return 'PriceItemInnerJoinBase{id: $id, name: $name, price: $price, tolerance: $tolerance, tickado: $tickado}';
  }
}