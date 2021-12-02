import 'package:app2park/module/ticket_sinc_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'ticket_sinc_response.g.dart';

@JsonSerializable()
class TicketSincResponse{
  String status;
  String message;
  List<TicketSincModel> allticketsopen;


  TicketSincResponse({this.status, this.message, this.allticketsopen});

  factory TicketSincResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketSincResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketSincResponseToJson(this);
}