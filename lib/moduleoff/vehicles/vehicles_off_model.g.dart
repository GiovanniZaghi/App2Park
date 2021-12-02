// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesOffModel _$VehiclesOffModelFromJson(Map<String, dynamic> json) {
  return VehiclesOffModel(
    json['id'] as int,
    json['id_vehicle_type'] as int,
    json['maker'] as String,
    json['model'] as String,
    json['color'] as String,
    json['plate'] as String,
    json['year'] as String,
  )..id_vehicle_app = json['id_vehicle_app'] as int;
}

Map<String, dynamic> _$VehiclesOffModelToJson(VehiclesOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_vehicle_app': instance.id_vehicle_app,
      'id_vehicle_type': instance.id_vehicle_type,
      'maker': instance.maker,
      'model': instance.model,
      'color': instance.color,
      'plate': instance.plate,
      'year': instance.year,
    };
