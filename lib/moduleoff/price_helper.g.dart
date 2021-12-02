// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_helper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceHelper _$PriceHelperFromJson(Map<String, dynamic> json) {
  return PriceHelper(
    json['id'] as int,
    json['id_price_detached_item_app'] as int,
    json['id_price_detached'] as int,
    json['id_price_detached_app'] as int,
    json['id_price_detached_item_base'] as int,
    (json['price'] as num)?.toDouble(),
    json['tolerance'] as String,
    json['name_table'] as String,
    json['name'] as String,
    json['time'] as String,
    json['type'] as String,
    json['level'] as int,
  );
}

Map<String, dynamic> _$PriceHelperToJson(PriceHelper instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_price_detached_item_app': instance.id_price_detached_item_app,
      'id_price_detached': instance.id_price_detached,
      'id_price_detached_app': instance.id_price_detached_app,
      'id_price_detached_item_base': instance.id_price_detached_item_base,
      'price': instance.price,
      'tolerance': instance.tolerance,
      'name_table': instance.name_table,
      'name': instance.name,
      'time': instance.time,
      'type': instance.type,
      'level': instance.level,
    };
