import 'package:app2park/module/park/ticket/ticket_object_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_object_response.g.dart';

@JsonSerializable()
class TicketObjectResponse{
  String status;
  List<TicketObjectModel> data;
  String message;

  TicketObjectResponse({this.status, this.data, this.message});

  factory TicketObjectResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketObjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketObjectResponseToJson(this);


}