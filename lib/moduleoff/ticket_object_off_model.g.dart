// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_object_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketObjectOffModel _$TicketObjectOffModelFromJson(Map<String, dynamic> json) {
  return TicketObjectOffModel(
    json['id'] as int,
    json['id_ticket'] as int,
    json['id_ticket_app'] as int,
    json['id_object'] as int,
  )..id_ticket_object_app = json['id_ticket_object_app'] as int;
}

Map<String, dynamic> _$TicketObjectOffModelToJson(
        TicketObjectOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket': instance.id_ticket,
      'id_ticket_object_app': instance.id_ticket_object_app,
      'id_ticket_app': instance.id_ticket_app,
      'id_object': instance.id_object,
    };
