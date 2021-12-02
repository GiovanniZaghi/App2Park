// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_historic_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoricPhotoResponse _$TicketHistoricPhotoResponseFromJson(
    Map<String, dynamic> json) {
  return TicketHistoricPhotoResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : TicketHistoricPhotoModel.fromJson(
            json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$TicketHistoricPhotoResponseToJson(
        TicketHistoricPhotoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
