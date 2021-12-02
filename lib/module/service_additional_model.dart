import 'package:json_annotation/json_annotation.dart';

part 'service_additional_model.g.dart';

@JsonSerializable()
class ServiceAdditionalModel{
  String id;
  String name;
  String id_vehicle_type;
  String sort_order;

  ServiceAdditionalModel({
      this.id, this.name, this.id_vehicle_type, this.sort_order});

  factory ServiceAdditionalModel.fromJson(Map<String, dynamic> json) => _$ServiceAdditionalModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceAdditionalModelToJson(this);

}