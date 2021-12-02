import 'package:json_annotation/json_annotation.dart';

part 'price_detached_off_inner_model.g.dart';

@JsonSerializable()
class PriceDetachedInnerJoinOff{
  int id;
  int id_price_detached_app;
  int id_park;
  String name;
  String daily_start;
  int id_vehicle_type;
  int id_status;
  int cash;
  int sort_order;
  String type;

  PriceDetachedInnerJoinOff(this.id, this.id_park, this.name, this.daily_start,
      this.id_vehicle_type, this.id_status, this.cash, this.sort_order, this.type);

  factory PriceDetachedInnerJoinOff.fromJson(Map<String, dynamic> json) =>
      _$PriceDetachedInnerJoinOffFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedInnerJoinOffToJson(this);
}