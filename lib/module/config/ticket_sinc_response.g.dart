// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_sinc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketSincResponse _$TicketSincResponseFromJson(Map<String, dynamic> json) {
  return TicketSincResponse(
    status: json['status'] as String,
    message: json['message'] as String,
    allticketsopen: (json['allticketsopen'] as List)
        ?.map((e) => e == null
            ? null
            : TicketSincModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TicketSincResponseToJson(TicketSincResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'allticketsopen': instance.allticketsopen,
    };
