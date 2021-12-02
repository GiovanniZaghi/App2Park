import 'package:json_annotation/json_annotation.dart';

part 'ticket_sinc_model.g.dart';

@JsonSerializable()
class TicketSincModel{
  String id_ticket;
  String id_park;
  String id_ticket_historic_status;

  TicketSincModel({this.id_ticket, this.id_park, this.id_ticket_historic_status});

  factory TicketSincModel.fromJson(Map<String, dynamic> json) => _$TicketSincModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketSincModelToJson(this);
}