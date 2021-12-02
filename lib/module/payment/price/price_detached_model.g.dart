// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetached _$PriceDetachedFromJson(Map<String, dynamic> json) {
  return PriceDetached(
    id: json['id'] as String,
    id_price_detached_app: json['id_price_detached_app'] as String,
    id_park: json['id_park'] as String,
    name: json['name'] as String,
    daily_start: json['daily_start'] as String,
    id_vehicle_type: json['id_vehicle_type'] as String,
    id_status: json['id_status'] as String,
    cash: json['cash'] as String,
    sort_order: json['sort_order'] as String,
    data_sinc: json['data_sinc'] as String,
  );
}

Map<String, dynamic> _$PriceDetachedToJson(PriceDetached instance) =>
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
