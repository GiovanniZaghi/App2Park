import 'package:app2park/module/park/ticket/ticket_service_additional_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_service_additional_response.g.dart';

@JsonSerializable()
class TicketServiceAdditionalResponse{
  String status;
  TicketServiceAdditionalModel data;
  String message;

  TicketServiceAdditionalResponse({this.status, this.data, this.message});

  factory TicketServiceAdditionalResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketServiceAdditionalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketServiceAdditionalResponseToJson(this);


}