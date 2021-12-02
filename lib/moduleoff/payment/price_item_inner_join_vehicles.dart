import 'package:json_annotation/json_annotation.dart';

part 'price_item_inner_join_vehicles.g.dart';

@JsonSerializable()
class PriceItemInnerJoinVehicles{
  String type;
  int id;
  int id_price_detached_app;
  int id_park;
  String name;
  String daily_start;
  int id_vehicle_type;
  String status;
  int cash;
  int id_status;
  int sort_order;

  PriceItemInnerJoinVehicles(
      this.type,
      this.id,
      this.id_price_detached_app,
      this.id_park,
      this.name,
      this.daily_start,
      this.id_vehicle_type,
      this.status,
      this.cash,
      this.id_status,
      this.sort_order);

  factory PriceItemInnerJoinVehicles.fromJson(Map<String, dynamic> json) =>
      _$PriceItemInnerJoinVehiclesFromJson(json);

  Map<String, dynamic> toJson() => _$PriceItemInnerJoinVehiclesToJson(this);
}