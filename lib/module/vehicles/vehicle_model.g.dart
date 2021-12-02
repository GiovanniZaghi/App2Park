// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) {
  return VehicleModel(
    json['id'] as String,
    json['id_vehicle_type'] as String,
    json['maker'] as String,
    json['model'] as String,
    json['color'] as String,
    json['plate'] as String,
    json['year'] as String,
  );
}

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_vehicle_type': instance.id_vehicle_type,
      'maker': instance.maker,
      'model': instance.model,
      'color': instance.color,
      'plate': instance.plate,
      'year': instance.year,
    };
