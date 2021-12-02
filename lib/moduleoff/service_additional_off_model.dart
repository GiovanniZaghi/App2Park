import 'package:json_annotation/json_annotation.dart';

part 'service_additional_off_model.g.dart';

@JsonSerializable()
class ServiceAdditionalOffModel{
  int id;
  String name;
  int id_vehicle_type;
  int sort_order;

  ServiceAdditionalOffModel(
      this.id, this.name, this.id_vehicle_type, this.sort_order);

  factory ServiceAdditionalOffModel.fromJson(Map<String, dynamic> json) => _$ServiceAdditionalOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceAdditionalOffModelToJson(this);

}