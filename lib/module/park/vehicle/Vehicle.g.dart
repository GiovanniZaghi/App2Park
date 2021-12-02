// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle(
    id: json['id'] as String,
    type: json['type'] as String,
    maker: json['maker'] as String,
    model: json['model'] as String,
    color: json['color'] as String,
    plate: json['plate'] as String,
    year: json['year'] as String,
  );
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'maker': instance.maker,
      'model': instance.model,
      'color': instance.color,
      'plate': instance.plate,
      'year': instance.year,
    };
