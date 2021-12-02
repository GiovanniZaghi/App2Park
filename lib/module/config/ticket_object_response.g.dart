// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_object_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketObjectResponse _$TicketObjectResponseFromJson(Map<String, dynamic> json) {
  return TicketObjectResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TicketObjectModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$TicketObjectResponseToJson(
        TicketObjectResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
