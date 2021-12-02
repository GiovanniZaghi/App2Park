// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_sinc_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketSincModel _$TicketSincModelFromJson(Map<String, dynamic> json) {
  return TicketSincModel(
    id_ticket: json['id_ticket'] as String,
    id_park: json['id_park'] as String,
    id_ticket_historic_status: json['id_ticket_historic_status'] as String,
  );
}

Map<String, dynamic> _$TicketSincModelToJson(TicketSincModel instance) =>
    <String, dynamic>{
      'id_ticket': instance.id_ticket,
      'id_park': instance.id_park,
      'id_ticket_historic_status': instance.id_ticket_historic_status,
    };
