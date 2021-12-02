import 'package:json_annotation/json_annotation.dart';

part 'price_detached_off_model.g.dart';

@JsonSerializable()
class PriceDetachedOff{
  int id;
  int id_price_detached_app;
  int id_park;
  String name;
  String daily_start;
  int id_vehicle_type;
  int id_status;
  int cash;
  int sort_order;
  String data_sinc;

  PriceDetachedOff(this.id, this.id_park, this.name, this.daily_start,
    this.id_vehicle_type, this.id_status, this.cash, this.sort_order, this.data_sinc);

  factory PriceDetachedOff.fromJson(Map<String, dynamic> json) =>
      _$PriceDetachedOffFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedOffToJson(this);
}