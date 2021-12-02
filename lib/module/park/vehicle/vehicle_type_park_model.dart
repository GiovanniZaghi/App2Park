import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_park_model.g.dart';

@JsonSerializable()
class VehicleTypeParkModel {
  String id;
  String id_vehicle_type;
  String id_park;
  String status;
  String sort_order;

  VehicleTypeParkModel({this.id, this.id_vehicle_type, this.id_park, this.status,
      this.sort_order});

  factory VehicleTypeParkModel.fromJson(Map<String, dynamic> json) => _$VehicleTypeParkModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeParkModelToJson(this);

  @override
  String toString() {
    return 'VehicleTypeParkModel{id: $id, id_vehicle_type: $id_vehicle_type, id_park: $id_park, status: $status, sort_order: $sort_order}';
  }
}