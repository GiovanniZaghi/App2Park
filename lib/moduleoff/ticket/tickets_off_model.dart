import 'package:json_annotation/json_annotation.dart';

part 'tickets_off_model.g.dart';

@JsonSerializable()
class TicketsOffModel{
  int id;
  int id_ticket_app;
  int id_park;
  int id_user;
  int id_vehicle;
  int id_vehicle_app;
  int id_customer;
  int id_customer_app;
  int id_agreement;
  int id_agreement_app;
  int id_cupom;
  int id_price_detached;
  int id_price_detached_app;
  String cupom_entrance_datetime;
  String pay_until;


  TicketsOffModel(
      this.id,
      this.id_park,
      this.id_user,
      this.id_vehicle,
      this.id_vehicle_app,
      this.id_customer,
      this.id_customer_app,
      this.id_agreement,
      this.id_agreement_app,
      this.id_cupom,
      this.id_price_detached,
      this.id_price_detached_app,
      this.cupom_entrance_datetime,
      this.pay_until);

  factory TicketsOffModel.fromJson(Map<String, dynamic> json) => _$TicketsOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketsOffModelToJson(this);

  @override
  String toString() {
    return 'TicketsOffModel{id: $id, id_ticket_app: $id_ticket_app, id_park: $id_park, id_user: $id_user, id_vehicle: $id_vehicle, id_vehicle_app: $id_vehicle_app, id_customer: $id_customer, id_customer_app: $id_customer_app, id_agreement: $id_agreement, id_agreement_app: $id_agreement_app, id_cupom: $id_cupom, id_price_detached: $id_price_detached, id_price_detached_app: $id_price_detached_app, cupom_entrance_datetime: $cupom_entrance_datetime, pay_until: $pay_until}';
  }
}