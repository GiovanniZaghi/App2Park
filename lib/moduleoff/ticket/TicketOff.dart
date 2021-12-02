import 'package:json_annotation/json_annotation.dart';

part 'TicketOff.g.dart';

@JsonSerializable()
class TicketOff{
  int ticket_id_app;
  int id_user;
  int id_park;
  int id_vehicle;
  int id_customer;
  String cupom;
  String cupom_checkin_datetime;
  String data_added;


  TicketOff(this.id_user, this.id_park, this.id_vehicle,
      this.id_customer, this.cupom, this.cupom_checkin_datetime,
      this.data_added);

  factory TicketOff.fromJson(Map<String, dynamic> json) => _$TicketOffFromJson(json);

  Map<String, dynamic> toJson() => _$TicketOffToJson(this);
}