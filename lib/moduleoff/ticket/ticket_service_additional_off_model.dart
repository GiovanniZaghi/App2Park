import 'package:json_annotation/json_annotation.dart';

part 'ticket_service_additional_off_model.g.dart';

@JsonSerializable()
class TicketServiceAdditionalOffModel{
  int id;
  int id_ticket;
  int id_ticket_service_additional_app;
  int id_ticket_app;
  int id_park_service_additional;
  String name;
  double price;
  String lack;
  String finish_estimate;
  String price_justification;
  String observation;
  int id_status;

  TicketServiceAdditionalOffModel(
      this.id,
      this.id_ticket,
      this.id_ticket_app,
      this.id_park_service_additional,
      this.name,
      this.price,
      this.lack,
      this.finish_estimate,
      this.price_justification,
      this.observation,
      this.id_status);

  factory TicketServiceAdditionalOffModel.fromJson(Map<String, dynamic> json) => _$TicketServiceAdditionalOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketServiceAdditionalOffModelToJson(this);
}