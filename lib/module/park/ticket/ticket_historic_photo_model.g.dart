// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_historic_photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoricPhotoModel _$TicketHistoricPhotoModelFromJson(
    Map<String, dynamic> json) {
  return TicketHistoricPhotoModel(
    id: json['id'] as String,
    id_historic_photo_app: json['id_historic_photo_app'] as String,
    id_ticket_historic: json['id_ticket_historic'] as String,
    id_ticket_historic_app: json['id_ticket_historic_app'] as String,
    photo: json['photo'] as String,
    date_time: json['date_time'] as String,
  );
}

Map<String, dynamic> _$TicketHistoricPhotoModelToJson(
        TicketHistoricPhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_historic_photo_app': instance.id_historic_photo_app,
      'id_ticket_historic': instance.id_ticket_historic,
      'id_ticket_historic_app': instance.id_ticket_historic_app,
      'photo': instance.photo,
      'date_time': instance.date_time,
    };
