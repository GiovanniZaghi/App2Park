import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_status_model.g.dart';

@JsonSerializable()
class TicketHistoricStatusModel{
  String id;
  String name;

  TicketHistoricStatusModel(this.id, this.name);

  factory TicketHistoricStatusModel.fromJson(Map<String, dynamic> json) => _$TicketHistoricStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricStatusModelToJson(this);
}