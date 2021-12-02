import 'package:json_annotation/json_annotation.dart';

part 'ticket_off_leftjoin_model.g.dart';

@JsonSerializable()
class TicketsOffLeftJoinModel{
  int id;
  int id_ticket_app;
  int id_cupom;
  int id_object;
  int id_service;
  String plate;
  String model;
  String type;

  TicketsOffLeftJoinModel(this.id, this.id_ticket_app, this.id_cupom,
      this.id_object, this.id_service, this.plate, this.model, this.type);

  factory TicketsOffLeftJoinModel.fromJson(Map<String, dynamic> json) => _$TicketsOffLeftJoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketsOffLeftJoinModelToJson(this);

  @override
  String toString() {
    return 'TicketsOffLeftJoinModel{id: $id, id_ticket_app: $id_ticket_app, id_cupom: $id_cupom, id_object: $id_object, id_service: $id_service, plate: $plate, model: $model, type: $type}';
  }
}