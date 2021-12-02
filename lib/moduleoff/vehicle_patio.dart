import 'package:json_annotation/json_annotation.dart';

part 'vehicle_patio.g.dart';

@JsonSerializable()
class VehiclePatio{
  int id_ticket_historic_app;
  int id_ticket_app;
  String date_time;
  int id_ticket_historic_status;
  int id_ticket;
  int id_cupom;
  String maker;
  String model;
  String color;
  String plate;
  String year;
  String email;
  String cell;

  VehiclePatio(
      this.id_ticket_historic_app,
      this.id_ticket_app,
      this.date_time,
      this.id_ticket_historic_status,
      this.id_ticket,
      this.id_cupom,
      this.maker,
      this.model,
      this.color,
      this.plate,
      this.year,
      this.email,
      this.cell);

  factory VehiclePatio.fromJson(Map<String, dynamic> json) => _$VehiclePatioFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclePatioToJson(this);

  @override
  String toString() {
    return 'VehiclePatio{id_ticket_historic_app: $id_ticket_historic_app, id_ticket_app: $id_ticket_app, date_time: $date_time, id_ticket_historic_status: $id_ticket_historic_status, id_ticket: $id_ticket, id_cupom: $id_cupom, maker: $maker, model: $model, color: $color, plate: $plate, year: $year, email: $email, cell: $cell}';
  }
}