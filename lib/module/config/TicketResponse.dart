import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TicketResponse.g.dart';

@JsonSerializable()
class TicketResponse {
  String status;
  Ticket data;
  String message;

  TicketResponse({this.status, this.data, this.message});

  factory TicketResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketResponseToJson(this);
}