import 'package:json_annotation/json_annotation.dart';

part 'ticket_service_additional_model.g.dart';

@JsonSerializable()

class TicketServiceAdditionalModel{
  String id;
  String id_ticket_service_additional_app;
  String id_ticket;
  String id_ticket_app;
  String id_park_service_additional;
  String name;
  String price;
  String tolerance;
  String finish_estimate;
  String price_justification;
  String observation;
  String id_status;

  TicketServiceAdditionalModel(
     { this.id,
      this.id_ticket_service_additional_app,
      this.id_ticket,
      this.id_ticket_app,
      this.id_park_service_additional,
      this.name,
      this.price,
      this.tolerance,
      this.finish_estimate,
      this.price_justification,
      this.observation,
      this.id_status});

  factory TicketServiceAdditionalModel.fromJson(Map<String, dynamic> json) => _$TicketServiceAdditionalModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketServiceAdditionalModelToJson(this);

  @override
  String toString() {
    return 'TicketServiceAdditionalModel{id: $id, id_ticket_service_additional_app: $id_ticket_service_additional_app, id_ticket: $id_ticket, id_ticket_app: $id_ticket_app, id_park_service_additional: $id_park_service_additional, name: $name, price: $price, tolerance: $tolerance, finish_estimate: $finish_estimate, price_justification: $price_justification, observation: $observation, id_status: $id_status}';
  }
}