import 'package:json_annotation/json_annotation.dart';

part 'ticket_object_off_model.g.dart';

@JsonSerializable()
class TicketObjectOffModel{
  int id;
  int id_ticket;
  int id_ticket_object_app;
  int id_ticket_app;
  int id_object;

  TicketObjectOffModel(this.id, this.id_ticket,
      this.id_ticket_app, this.id_object);

  factory TicketObjectOffModel.fromJson(Map<String, dynamic> json) => _$TicketObjectOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketObjectOffModelToJson(this);
}