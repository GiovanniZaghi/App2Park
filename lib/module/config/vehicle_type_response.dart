import 'package:app2park/module/park/vehicle/vehicle_type_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_response.g.dart';

@JsonSerializable()
class VehicleTypeResponse{
  String status;
  List<VehicleTypeModel> data;
  String message;

  VehicleTypeResponse({this.status, this.data, this.message});

  factory VehicleTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTypeResponseToJson(this);


}