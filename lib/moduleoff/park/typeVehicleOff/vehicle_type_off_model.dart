import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_off_model.g.dart';

@JsonSerializable()
class VehicleTypeOffModel{
  int id;
  String type;

  VehicleTypeOffModel(this.id, this.type);

  factory VehicleTypeOffModel.fromJson(Map<String, dynamic> json) => _$VehicleTypeOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeOffModelToJson(this);

  @override
  String toString() {
    return 'VehicleTypeOffModel{id: $id, type: $type}';
  }



}