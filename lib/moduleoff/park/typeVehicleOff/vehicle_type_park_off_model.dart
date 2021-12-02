import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_park_off_model.g.dart';

@JsonSerializable()
class VehicleTypeParkOffModel{
  int id;
  int id_vehicle_type;
  int id_park;
  int status;
  int sort_order;

  VehicleTypeParkOffModel(this.id, this.id_vehicle_type, this.id_park,
      this.status, this.sort_order);

  factory VehicleTypeParkOffModel.fromJson(Map<String, dynamic> json) => _$VehicleTypeParkOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeParkOffModelToJson(this);

  @override
  String toString() {
    return 'VehicleTypeParkOffModel{id: $id, id_vehicle_type: $id_vehicle_type, id_park: $id_park, status: $status, sort_order: $sort_order}';
  }
}