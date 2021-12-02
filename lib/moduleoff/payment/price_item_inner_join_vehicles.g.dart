// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_item_inner_join_vehicles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceItemInnerJoinVehicles _$PriceItemInnerJoinVehiclesFromJson(
    Map<String, dynamic> json) {
  return PriceItemInnerJoinVehicles(
    json['type'] as String,
    json['id'] as int,
    json['id_price_detached_app'] as int,
    json['id_park'] as int,
    json['name'] as String,
    json['daily_start'] as String,
    json['id_vehicle_type'] as int,
    json['status'] as String,
    json['cash'] as int,
    json['id_status'] as int,
    json['sort_order'] as int,
  );
}

Map<String, dynamic> _$PriceItemInnerJoinVehiclesToJson(
        PriceItemInnerJoinVehicles instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'id_price_detached_app': instance.id_price_detached_app,
      'id_park': instance.id_park,
      'name': instance.name,
      'daily_start': instance.daily_start,
      'id_vehicle_type': instance.id_vehicle_type,
      'status': instance.status,
      'cash': instance.cash,
      'id_status': instance.id_status,
      'sort_order': instance.sort_order,
    };
