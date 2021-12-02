import 'package:json_annotation/json_annotation.dart';

part 'ticket_object_model.g.dart';

@JsonSerializable()
class TicketObjectModel{
  String id;
  String id_ticket_object_app;
  String id_ticket;
  String id_ticket_app;
  String id_object;

  TicketObjectModel({this.id, this.id_ticket_object_app, this.id_ticket,
      this.id_ticket_app, this.id_object});

  factory TicketObjectModel.fromJson(Map<String, dynamic> json) => _$TicketObjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketObjectModelToJson(this);

  @override
  String toString() {
    return 'TicketObjectModel{id: $id, id_ticket_object_app: $id_ticket_object_app, id_ticket: $id_ticket, id_ticket_app: $id_ticket_app, id_object: $id_object}';
  }
}