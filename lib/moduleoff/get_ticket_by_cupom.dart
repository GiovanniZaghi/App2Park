import 'package:json_annotation/json_annotation.dart';

part 'get_ticket_by_cupom.g.dart';

@JsonSerializable()

class GetTicketByCupom{
  int id_ticket_app;

  GetTicketByCupom(this.id_ticket_app);

  factory GetTicketByCupom.fromJson(Map<String, dynamic> json) => _$GetTicketByCupomFromJson(json);

  Map<String, dynamic> toJson() => _$GetTicketByCupomToJson(this);
}