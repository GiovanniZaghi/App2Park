import 'package:json_annotation/json_annotation.dart';

part 'exit_join_model.g.dart';

@JsonSerializable()
class ExitJoinModel{
  int id_ticket_app;
  int id_cupom;
  int id_ticket_historic_status;
  String name;
  String date_time;
  String plate;
  String model;
  String type;


  ExitJoinModel(
      this.id_ticket_app,
      this.id_cupom,
      this.id_ticket_historic_status,
      this.name,
      this.date_time,
      this.plate,
      this.model,
      this.type);

  factory ExitJoinModel.fromJson(Map<String, dynamic> json) => _$ExitJoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExitJoinModelToJson(this);

  @override
  String toString() {
    return 'ExitJoinModel{id_ticket_app: $id_ticket_app, id_cupom: $id_cupom, id_ticket_historic_status: $id_ticket_historic_status, name: $name, date_time: $date_time, plate: $plate, model: $model, type: $type}';
  }
}