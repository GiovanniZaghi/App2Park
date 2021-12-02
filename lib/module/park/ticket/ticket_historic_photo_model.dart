import 'package:json_annotation/json_annotation.dart';

part 'ticket_historic_photo_model.g.dart';

@JsonSerializable()
class TicketHistoricPhotoModel{
  String id;
  String id_historic_photo_app;
  String id_ticket_historic;
  String id_ticket_historic_app;
  String photo;
  String date_time;

  TicketHistoricPhotoModel(
     { this.id,
      this.id_historic_photo_app,
      this.id_ticket_historic,
      this.id_ticket_historic_app,
      this.photo,
      this.date_time});

  factory TicketHistoricPhotoModel.fromJson(Map<String, dynamic> json) => _$TicketHistoricPhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketHistoricPhotoModelToJson(this);

  @override
  String toString() {
    return 'TicketHistoricPhotoModel{id: $id, id_historic_photo_app: $id_historic_photo_app, id_ticket_historic: $id_ticket_historic, id_ticket_historic_app: $id_ticket_historic_app, photo: $photo, date_time: $date_time}';
  }
}