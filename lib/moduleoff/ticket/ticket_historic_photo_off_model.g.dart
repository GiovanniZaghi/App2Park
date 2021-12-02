// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_historic_photo_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoricPhotoOffModel _$TicketHistoricPhotoOffModelFromJson(
    Map<String, dynamic> json) {
  return TicketHistoricPhotoOffModel(
    json['id'] as int,
    json['id_ticket_historic'] as int,
    json['id_ticket_historic_app'] as int,
    json['photo'] as String,
    json['date_time'] as String,
  )..id_historic_photo_app = json['id_historic_photo_app'] as int;
}

Map<String, dynamic> _$TicketHistoricPhotoOffModelToJson(
        TicketHistoricPhotoOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket_historic': instance.id_ticket_historic,
      'id_historic_photo_app': instance.id_historic_photo_app,
      'id_ticket_historic_app': instance.id_ticket_historic_app,
      'photo': instance.photo,
      'date_time': instance.date_time,
    };
