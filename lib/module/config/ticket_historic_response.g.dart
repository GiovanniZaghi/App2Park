// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_historic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoricResponse _$TicketHistoricResponseFromJson(
    Map<String, dynamic> json) {
  return TicketHistoricResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : TicketHistoricModel.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$TicketHistoricResponseToJson(
        TicketHistoricResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
