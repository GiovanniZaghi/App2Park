// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_item_base_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedItemBaseOff _$PriceDetachedItemBaseOffFromJson(
    Map<String, dynamic> json) {
  return PriceDetachedItemBaseOff(
    json['id'] as int,
    json['name'] as String,
    json['time'] as String,
    json['type'] as String,
    json['level'] as int,
    json['id_status'] as int,
  );
}

Map<String, dynamic> _$PriceDetachedItemBaseOffToJson(
        PriceDetachedItemBaseOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time': instance.time,
      'type': instance.type,
      'level': instance.level,
      'id_status': instance.id_status,
    };
