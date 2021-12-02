import 'package:json_annotation/json_annotation.dart';

part 'exit_service_additional_model.g.dart';

@JsonSerializable()
class ExitServiceAdditionalModel{
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

  ExitServiceAdditionalModel(
      this.id,
      this.id_ticket,
      this.id_ticket_service_additional_app,
      this.id_ticket_app,
      this.id_park_service_additional,
      this.name,
      this.price,
      this.lack,
      this.finish_estimate,
      this.price_justification,
      this.observation,
      this.id_status);

  factory ExitServiceAdditionalModel.fromJson(Map<String, dynamic> json) => _$ExitServiceAdditionalModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExitServiceAdditionalModelToJson(this);

  @override
  String toString() {
    return '{id: $id, id_ticket: $id_ticket, id_ticket_service_additional_app: $id_ticket_service_additional_app, id_ticket_app: $id_ticket_app, id_park_service_additional: $id_park_service_additional, name: $name, price: $price, lack: $lack, finish_estimate: $finish_estimate, price_justification: $price_justification, observation: $observation, id_status: $id_status}';
  }
}