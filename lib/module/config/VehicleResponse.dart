import 'package:app2park/module/park/vehicle/Vehicle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'VehicleResponse.g.dart';

@JsonSerializable()
class VehicleResponse{
  String status;
  Vehicle data;
  String message;

  VehicleResponse({this.status, this.data, this.message});

  factory VehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResponseToJson(this);


}