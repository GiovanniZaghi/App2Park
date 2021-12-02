// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_item_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedBase _$PriceDetachedBaseFromJson(Map<String, dynamic> json) {
  return PriceDetachedBase(
    id: json['id'] as String,
    name: json['name'] as String,
    time: json['time'] as String,
    type: json['type'] as String,
    level: json['level'] as String,
    id_status: json['id_status'] as String,
  );
}

Map<String, dynamic> _$PriceDetachedBaseToJson(PriceDetachedBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time': instance.time,
      'type': instance.type,
      'level': instance.level,
      'id_status': instance.id_status,
    };
