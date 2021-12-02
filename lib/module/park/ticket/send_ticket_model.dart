import 'package:json_annotation/json_annotation.dart';

part 'send_ticket_model.g.dart';

@JsonSerializable()
class SendTicketModelModel{
  String id_ticket;

  SendTicketModelModel({this.id_ticket});

  factory SendTicketModelModel.fromJson(Map<String, dynamic> json) => _$SendTicketModelModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendTicketModelModelToJson(this);

  @override
  String toString() {
    return 'SendTicketModelModel{id_ticket: $id_ticket}';
  }
}