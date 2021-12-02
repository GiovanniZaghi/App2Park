import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_model.g.dart';

@JsonSerializable()
class VehicleTypeModel {
  String id;
  String type;

  VehicleTypeModel({this.id, this.type});

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) => _$VehicleTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeModelToJson(this);

  @override
  String toString() {
    return 'VehicleTypeModel{id: $id, type: $type}';
  }
}