import 'package:json_annotation/json_annotation.dart';

part 'price_detached_item_base_model.g.dart';

@JsonSerializable()
class PriceDetachedBase{
  String id;
  String name;
  String time;
  String type;
  String level;
  String id_status;

  PriceDetachedBase({
      this.id, this.name, this.time, this.type, this.level, this.id_status});

  factory PriceDetachedBase.fromJson(Map<String, dynamic> json) =>
      _$PriceDetachedBaseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedBaseToJson(this);
}