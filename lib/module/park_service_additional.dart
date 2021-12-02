import 'package:json_annotation/json_annotation.dart';

part 'park_service_additional.g.dart';

@JsonSerializable()
class ParkServiceAdditional{
  String id;
  String id_service_additional;
  String id_park;
  String price;
  String tolerance;
  String sort_order;
  String status;
  String date_edited;

  ParkServiceAdditional(
     { this.id,
      this.id_service_additional,
      this.id_park,
      this.price,
      this.tolerance,
      this.sort_order,
      this.status,
      this.date_edited});

  factory ParkServiceAdditional.fromJson(Map<String, dynamic> json) => _$ParkServiceAdditionalFromJson(json);

  Map<String, dynamic> toJson() => _$ParkServiceAdditionalToJson(this);
}