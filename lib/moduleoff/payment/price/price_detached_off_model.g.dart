// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedOff _$PriceDetachedOffFromJson(Map<String, dynamic> json) {
  return PriceDetachedOff(
    json['id'] as int,
    json['id_park'] as int,
    json['name'] as String,
    json['daily_start'] as String,
    json['id_vehicle_type'] as int,
    json['id_status'] as int,
    json['cash'] as int,
    json['sort_order'] as int,
    json['data_sinc'] as String,
  )..id_price_detached_app = json['id_price_detached_app'] as int;
}

Map<String, dynamic> _$PriceDetachedOffToJson(PriceDetachedOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_price_detached_app': instance.id_price_detached_app,
      'id_park': instance.id_park,
      'name': instance.name,
      'daily_start': instance.daily_start,
      'id_vehicle_type': instance.id_vehicle_type,
      'id_status': instance.id_status,
      'cash': instance.cash,
      'sort_order': instance.sort_order,
      'data_sinc': instance.data_sinc,
    };
