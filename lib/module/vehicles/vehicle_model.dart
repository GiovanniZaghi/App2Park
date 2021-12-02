import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  String id;
  String id_vehicle_type;
  String maker;
  String model;
  String color;
  String plate;
  String year;

  VehicleModel(this.id, this.id_vehicle_type, this.maker, this.model,
      this.color, this.plate, this.year);

  factory VehicleModel.fromJson(Map<String, dynamic> json) => _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);

  @override
  String toString() {
    return 'VehicleModel{id: $id, id_vehicle_type: $id_vehicle_type, maker: $maker, model: $model, color: $color, plate: $plate, year: $year}';
  }
}