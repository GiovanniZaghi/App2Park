// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_object_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketObjectModel _$TicketObjectModelFromJson(Map<String, dynamic> json) {
  return TicketObjectModel(
    id: json['id'] as String,
    id_ticket_object_app: json['id_ticket_object_app'] as String,
    id_ticket: json['id_ticket'] as String,
    id_ticket_app: json['id_ticket_app'] as String,
    id_object: json['id_object'] as String,
  );
}

Map<String, dynamic> _$TicketObjectModelToJson(TicketObjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket_object_app': instance.id_ticket_object_app,
      'id_ticket': instance.id_ticket,
      'id_ticket_app': instance.id_ticket_app,
      'id_object': instance.id_object,
    };
