import 'package:json_annotation/json_annotation.dart';

part 'Vehicle.g.dart';

@JsonSerializable()
class Vehicle{
  String id;
  String type;
  String maker;
  String model;
  String color;
  String plate;
  String year;

  Vehicle({this.id, this.type, this.maker, this.model, this.color, this.plate,
      this.year});

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}