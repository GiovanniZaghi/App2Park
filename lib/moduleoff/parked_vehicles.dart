import 'package:json_annotation/json_annotation.dart';

part 'parked_vehicles.g.dart';

@JsonSerializable()
class ParkedVehicles{
  String name;
  String cell;
  String email;
  String type;
  String plate;
  String maker;
  String model;
  String color;
  String year;


  ParkedVehicles(this.name, this.cell, this.email, this.type, this.plate,
      this.maker, this.model, this.color, this.year);

  factory ParkedVehicles.fromJson(
      Map<String, dynamic> json) =>
      _$ParkedVehiclesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkedVehiclesToJson(this);

  @override
  String toString() {
    return 'ParkedVehicles{name: $name, cell: $cell, email: $email, type: $type, plate: $plate, maker: $maker, model: $model, color: $color, year: $year}';
  }
}
