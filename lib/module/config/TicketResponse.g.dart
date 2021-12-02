// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TicketResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketResponse _$TicketResponseFromJson(Map<String, dynamic> json) {
  return TicketResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Ticket.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$TicketResponseToJson(TicketResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
