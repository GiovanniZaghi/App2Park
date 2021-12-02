import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_innerjoin_typepark.g.dart';

@JsonSerializable()
class VehicleTypeInnerjoinTypePark{
  String type;
  int id;
  int id_vehicle_type;
  int id_park;
  int status;
  int sort_order;

  VehicleTypeInnerjoinTypePark({
      this.type, this.id, this.id_vehicle_type, this.id_park, this.status, this.sort_order});

  factory VehicleTypeInnerjoinTypePark.fromJson(Map<String, dynamic> json) => _$VehicleTypeInnerjoinTypeParkFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeInnerjoinTypeParkToJson(this);

  @override
  String toString() {
    return 'VehicleTypeInnerjoinTypePark{type: $type, id: $id, id_vehicle_type: $id_vehicle_type, id_park: $id_park, status: $status, sort_order: $sort_order}';
  }
}