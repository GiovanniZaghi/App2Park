// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_off_leftjoin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketsOffLeftJoinModel _$TicketsOffLeftJoinModelFromJson(
    Map<String, dynamic> json) {
  return TicketsOffLeftJoinModel(
    json['id'] as int,
    json['id_ticket_app'] as int,
    json['id_cupom'] as int,
    json['id_object'] as int,
    json['id_service'] as int,
    json['plate'] as String,
    json['model'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$TicketsOffLeftJoinModelToJson(
        TicketsOffLeftJoinModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_ticket_app': instance.id_ticket_app,
      'id_cupom': instance.id_cupom,
      'id_object': instance.id_object,
      'id_service': instance.id_service,
      'plate': instance.plate,
      'model': instance.model,
      'type': instance.type,
    };
