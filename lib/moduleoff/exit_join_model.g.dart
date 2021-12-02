// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exit_join_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExitJoinModel _$ExitJoinModelFromJson(Map<String, dynamic> json) {
  return ExitJoinModel(
    json['id_ticket_app'] as int,
    json['id_cupom'] as int,
    json['id_ticket_historic_status'] as int,
    json['name'] as String,
    json['date_time'] as String,
    json['plate'] as String,
    json['model'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$ExitJoinModelToJson(ExitJoinModel instance) =>
    <String, dynamic>{
      'id_ticket_app': instance.id_ticket_app,
      'id_cupom': instance.id_cupom,
      'id_ticket_historic_status': instance.id_ticket_historic_status,
      'name': instance.name,
      'date_time': instance.date_time,
      'plate': instance.plate,
      'model': instance.model,
      'type': instance.type,
    };
