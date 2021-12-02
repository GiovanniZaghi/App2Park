import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_off_model.g.dart';

@JsonSerializable()
class TicketHistoricOffModel{
  int id;
  int id_ticket;
  int id_ticket_historic_app;
  int id_ticket_app;
  int id_ticket_historic_status;
  int id_user;
  int id_service_additional;
  int id_service_additional_app;
  String date_time;

  TicketHistoricOffModel(
      this.id,
      this.id_ticket,
      this.id_ticket_app,
      this.id_ticket_historic_status,
      this.id_user,
      this.id_service_additional,
      this.id_service_additional_app,
      this.date_time);

  factory TicketHistoricOffModel.fromJson(Map<String, dynamic> json) => _$TicketHistoricOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricOffModelToJson(this);
}