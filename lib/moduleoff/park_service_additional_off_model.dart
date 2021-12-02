import 'package:json_annotation/json_annotation.dart';

part 'park_service_additional_off_model.g.dart';

@JsonSerializable()
class ParkServiceAdditionalOffModel{
  int id;
  int id_service_additional;
  int id_park;
  double price;
  String tolerance;
  int sort_order;
  int status;
  String date_edited;

  ParkServiceAdditionalOffModel(
      this.id,
      this.id_service_additional,
      this.id_park,
      this.price,
      this.tolerance,
      this.sort_order,
      this.status,
      this.date_edited);

  factory ParkServiceAdditionalOffModel.fromJson(Map<String, dynamic> json) => _$ParkServiceAdditionalOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParkServiceAdditionalOffModelToJson(this);
}