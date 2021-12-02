import 'package:json_annotation/json_annotation.dart';

part 'TicketSend.g.dart';

@JsonSerializable()
class TicketSend{
  String id_park;
  String id_vehicle;
  String id_customer;
  String id_user;
  String cupom;


  TicketSend({this.id_park, this.id_vehicle, this.id_customer, this.cupom, this.id_user});

  factory TicketSend.fromJson(Map<String, dynamic> json) => _$TicketSendFromJson(json);

  Map<String, dynamic> toJson() => _$TicketSendToJson(this);
}