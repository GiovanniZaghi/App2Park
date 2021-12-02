// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_historic_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoricStatusResponse _$TicketHistoricStatusResponseFromJson(
    Map<String, dynamic> json) {
  return TicketHistoricStatusResponse(
    json['status'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TicketHistoricStatusModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['message'] as String,
  );
}

Map<String, dynamic> _$TicketHistoricStatusResponseToJson(
        TicketHistoricStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
