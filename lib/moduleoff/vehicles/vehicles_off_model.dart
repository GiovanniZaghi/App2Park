import 'package:json_annotation/json_annotation.dart';

part 'vehicles_off_model.g.dart';

@JsonSerializable()
class VehiclesOffModel{
  int id;
  int id_vehicle_app;
  int id_vehicle_type;
  String maker;
  String model;
  String color;
  String plate;
  String year;

  VehiclesOffModel(this.id, this.id_vehicle_type,
      this.maker, this.model, this.color, this.plate, this.year);

  factory VehiclesOffModel.fromJson(Map<String, dynamic> json) => _$VehiclesOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesOffModelToJson(this);

  @override
  String toString() {
    return 'VehiclesOffModel{id: $id, id_vehicle_app: $id_vehicle_app, id_vehicle_type: $id_vehicle_type, maker: $maker, model: $model, color: $color, plate: $plate, year: $year}';
  }
}