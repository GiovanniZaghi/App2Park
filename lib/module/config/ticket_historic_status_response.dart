import 'package:app2park/module/park/ticket/ticket_historic_status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_status_response.g.dart';

@JsonSerializable()
class TicketHistoricStatusResponse{
  String status;
  List<TicketHistoricStatusModel> data;
  String message;

  TicketHistoricStatusResponse(this.status, this.data, this.message);

  factory TicketHistoricStatusResponse.fromJson(Map<String, dynamic> json) => _$TicketHistoricStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricStatusResponseToJson(this);
}