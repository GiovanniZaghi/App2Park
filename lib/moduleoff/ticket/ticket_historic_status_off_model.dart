import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_status_off_model.g.dart';

@JsonSerializable()
class TicketHistoricStatusOffModel{
  int id;
  String name;

  TicketHistoricStatusOffModel(this.id, this.name);

  factory TicketHistoricStatusOffModel.fromJson(Map<String, dynamic> json) => _$TicketHistoricStatusOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricStatusOffModelToJson(this);

  @override
  String toString() {
    return 'TicketHistoricStatusOffModel{id: $id, name: $name}';
  }
}