// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_item_inner_join_item_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceItemInnerJoinBase _$PriceItemInnerJoinBaseFromJson(
    Map<String, dynamic> json) {
  return PriceItemInnerJoinBase(
    json['id_price_detached_item_app'] as int,
    json['id'] as int,
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
    json['tolerance'] as String,
    json['tickado'] as int,
    json['type'] as String,
    json['level'] as int,
  );
}

Map<String, dynamic> _$PriceItemInnerJoinBaseToJson(
        PriceItemInnerJoinBase instance) =>
    <String, dynamic>{
      'id_price_detached_item_app': instance.id_price_detached_item_app,
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'tolerance': instance.tolerance,
      'tickado': instance.tickado,
      'type': instance.type,
      'level': instance.level,
    };
