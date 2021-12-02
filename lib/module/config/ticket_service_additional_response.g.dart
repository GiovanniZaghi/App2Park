// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_service_additional_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketServiceAdditionalResponse _$TicketServiceAdditionalResponseFromJson(
    Map<String, dynamic> json) {
  return TicketServiceAdditionalResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : TicketServiceAdditionalModel.fromJson(
            json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$TicketServiceAdditionalResponseToJson(
        TicketServiceAdditionalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
