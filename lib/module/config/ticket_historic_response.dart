import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/park/ticket/ticket_historic_status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_response.g.dart';

@JsonSerializable()
class TicketHistoricResponse{
  String status;
  TicketHistoricModel data;
  String message;

  TicketHistoricResponse({this.status, this.data, this.message});

  factory TicketHistoricResponse.fromJson(Map<String, dynamic> json) => _$TicketHistoricResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricResponseToJson(this);
}