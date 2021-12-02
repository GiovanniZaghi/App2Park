import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_park_checkbox.g.dart';

@JsonSerializable()
class VehicleTypeParkCheckBox{
  String type;
  bool status;

  VehicleTypeParkCheckBox({this.type, this.status});

  factory VehicleTypeParkCheckBox.fromJson(Map<String, dynamic> json) => _$VehicleTypeParkCheckBoxFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeParkCheckBoxToJson(this);

  @override
  String toString() {
    return 'VehicleTypeParkCheckBox{type: $type, status: $status}';
  }
}