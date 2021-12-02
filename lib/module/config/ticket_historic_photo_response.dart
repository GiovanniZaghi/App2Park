import 'package:app2park/module/park/ticket/ticket_historic_photo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_photo_response.g.dart';

@JsonSerializable()
class TicketHistoricPhotoResponse{
  String status;
  TicketHistoricPhotoModel data;
  String message;

  TicketHistoricPhotoResponse({this.status, this.data, this.message});

  factory TicketHistoricPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketHistoricPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricPhotoResponseToJson(this);


}