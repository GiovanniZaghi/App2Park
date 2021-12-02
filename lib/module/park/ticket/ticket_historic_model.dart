import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_model.g.dart';

@JsonSerializable()
class TicketHistoricModel{
  String id;
  String id_ticket_historic_app;
  String id_ticket;
  String id_ticket_app;
  String id_user;
  String id_ticket_historic_status;
  String id_service_additional;
  String date_time;

  TicketHistoricModel({
    this.id,
    this.id_ticket_historic_app,
    this.id_ticket,
    this.id_ticket_app,
    this.id_user,
    this.id_ticket_historic_status,
    this.id_service_additional,
    this.date_time});

  factory TicketHistoricModel.fromJson(Map<String, dynamic> json) => _$TicketHistoricModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricModelToJson(this);

  @override
  String toString() {
    return 'TicketHistoricStatusModel{id: $id, id_ticket_historic_app: $id_ticket_historic_app, id_ticket: $id_ticket, id_ticket_app: $id_ticket_app, id_user: $id_user, id_ticket_historic_status: $id_ticket_historic_status, id_service_additional: $id_service_additional, date_time: $date_time}';
  }
}