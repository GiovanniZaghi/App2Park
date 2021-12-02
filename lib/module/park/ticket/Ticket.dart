import 'package:json_annotation/json_annotation.dart';

part 'Ticket.g.dart';

@JsonSerializable()
class Ticket{
  String id;
  String id_ticket_app;
  String id_park;
  String id_user;
  String id_vehicle;
  String id_vehicle_app;
  String id_customer;
  String id_customer_app;
  String id_agreement;
  String id_agreement_app;
  String id_cupom;
  String id_price_detached;
  String id_price_detached_app;
  String cupom_entrance_datetime;
  String pay_until;

  Ticket({
      this.id,
      this.id_ticket_app,
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
  this.pay_until});

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  String toString() {
    return 'Ticket{id: $id, id_ticket_app: $id_ticket_app, id_park: $id_park, id_user: $id_user, id_vehicle: $id_vehicle, id_vehicle_app: $id_vehicle_app, id_customer: $id_customer, id_customer_app: $id_customer_app, id_agreement: $id_agreement, id_agreement_app: $id_agreement_app, id_cupom: $id_cupom, id_price_detached: $id_price_detached, id_price_detached_app: $id_price_detached_app, cupom_entrance_datetime: $cupom_entrance_datetime, pay_until: $pay_until}';
  }
}