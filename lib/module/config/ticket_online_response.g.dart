// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_online_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketOnlineResponse _$TicketOnlineResponseFromJson(Map<String, dynamic> json) {
  return TicketOnlineResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : TicketOnlineModel.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$TicketOnlineResponseToJson(
        TicketOnlineResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
