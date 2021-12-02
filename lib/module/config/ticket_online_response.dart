import 'package:app2park/module/park/ticket/ticket_online_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_online_response.g.dart';

@JsonSerializable()
class TicketOnlineResponse{
  String status;
  TicketOnlineModel data;
  String message;

  TicketOnlineResponse({this.status, this.data, this.message});

  factory TicketOnlineResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketOnlineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketOnlineResponseToJson(this);


}