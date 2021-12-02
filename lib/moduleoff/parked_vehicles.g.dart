// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parked_vehicles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkedVehicles _$ParkedVehiclesFromJson(Map<String, dynamic> json) {
  return ParkedVehicles(
    json['name'] as String,
    json['cell'] as String,
    json['email'] as String,
    json['type'] as String,
    json['plate'] as String,
    json['maker'] as String,
    json['model'] as String,
    json['color'] as String,
    json['year'] as String,
  );
}

Map<String, dynamic> _$ParkedVehiclesToJson(ParkedVehicles instance) =>
    <String, dynamic>{
      'name': instance.name,
      'cell': instance.cell,
      'email': instance.email,
      'type': instance.type,
      'plate': instance.plate,
      'maker': instance.maker,
      'model': instance.model,
      'color': instance.color,
      'year': instance.year,
    };
