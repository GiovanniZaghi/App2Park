import 'package:json_annotation/json_annotation.dart';

part 'vehicle_app_ss.g.dart';

@JsonSerializable()
class VehicleAppSS{
  int id_vehicle_app;

  VehicleAppSS(this.id_vehicle_app);

  factory VehicleAppSS.fromJson(Map<String, dynamic> json) => _$VehicleAppSSFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleAppSSToJson(this);
}