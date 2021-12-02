import 'package:app2park/module/park/vehicle/vehicle_type_park_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_park_response.g.dart';

@JsonSerializable()
class VehicleTypeParkResponse{
  String status;
  List<VehicleTypeParkModel> data;
  String message;

  VehicleTypeParkResponse({this.status, this.data, this.message});

  factory VehicleTypeParkResponse.fromJson(Map<String, dynamic> json) => _$VehicleTypeParkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeParkResponseToJson(this);

}