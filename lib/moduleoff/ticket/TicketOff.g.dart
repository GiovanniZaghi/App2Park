// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TicketOff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketOff _$TicketOffFromJson(Map<String, dynamic> json) {
  return TicketOff(
    json['id_user'] as int,
    json['id_park'] as int,
    json['id_vehicle'] as int,
    json['id_customer'] as int,
    json['cupom'] as String,
    json['cupom_checkin_datetime'] as String,
    json['data_added'] as String,
  )..ticket_id_app = json['ticket_id_app'] as int;
}

Map<String, dynamic> _$TicketOffToJson(TicketOff instance) => <String, dynamic>{
      'ticket_id_app': instance.ticket_id_app,
      'id_user': instance.id_user,
      'id_park': instance.id_park,
      'id_vehicle': instance.id_vehicle,
      'id_customer': instance.id_customer,
      'cupom': instance.cupom,
      'cupom_checkin_datetime': instance.cupom_checkin_datetime,
      'data_added': instance.data_added,
    };
