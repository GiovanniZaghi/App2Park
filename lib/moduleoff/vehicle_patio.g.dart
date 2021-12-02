// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_patio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclePatio _$VehiclePatioFromJson(Map<String, dynamic> json) {
  return VehiclePatio(
    json['id_ticket_historic_app'] as int,
    json['id_ticket_app'] as int,
    json['date_time'] as String,
    json['id_ticket_historic_status'] as int,
    json['id_ticket'] as int,
    json['id_cupom'] as int,
    json['maker'] as String,
    json['model'] as String,
    json['color'] as String,
    json['plate'] as String,
    json['year'] as String,
    json['email'] as String,
    json['cell'] as String,
  );
}

Map<String, dynamic> _$VehiclePatioToJson(VehiclePatio instance) =>
    <String, dynamic>{
      'id_ticket_historic_app': instance.id_ticket_historic_app,
      'id_ticket_app': instance.id_ticket_app,
      'date_time': instance.date_time,
      'id_ticket_historic_status': instance.id_ticket_historic_status,
      'id_ticket': instance.id_ticket,
      'id_cupom': instance.id_cupom,
      'maker': instance.maker,
      'model': instance.model,
      'color': instance.color,
      'plate': instance.plate,
      'year': instance.year,
      'email': instance.email,
      'cell': instance.cell,
    };
