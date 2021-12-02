import 'package:json_annotation/json_annotation.dart';

part 'price_detached_model.g.dart';

@JsonSerializable()
class PriceDetached{
  String id;
  String id_price_detached_app;
  String id_park;
  String name;
  String daily_start;
  String id_vehicle_type;
  String id_status;
  String cash;
  String sort_order;
  String data_sinc;

  PriceDetached({this.id, this.id_price_detached_app, this.id_park, this.name, this.daily_start,
      this.id_vehicle_type, this.id_status, this.cash, this.sort_order, this.data_sinc});

  factory PriceDetached.fromJson(Map<String, dynamic> json) =>
      _$PriceDetachedFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedToJson(this);
}