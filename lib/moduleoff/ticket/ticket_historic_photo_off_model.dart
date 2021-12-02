import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_photo_off_model.g.dart';

@JsonSerializable()
class TicketHistoricPhotoOffModel{
  int id;
  int id_ticket_historic;
  int id_historic_photo_app;
  int id_ticket_historic_app;
  String photo;
  String date_time;

  TicketHistoricPhotoOffModel(
      this.id,
      this.id_ticket_historic,
      this.id_ticket_historic_app,
      this.photo,
      this.date_time);

  factory TicketHistoricPhotoOffModel.fromJson(Map<String, dynamic> json) => _$TicketHistoricPhotoOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricPhotoOffModelToJson(this);
}