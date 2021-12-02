// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_item_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedItemOff _$PriceDetachedItemOffFromJson(Map<String, dynamic> json) {
  return PriceDetachedItemOff(
    json['id'] as int,
    json['id_price_detached'] as int,
    json['id_price_detached_app'] as int,
    json['id_price_detached_item_base'] as int,
    (json['price'] as num)?.toDouble(),
    json['tolerance'] as String,
  )..id_price_detached_item_app = json['id_price_detached_item_app'] as int;
}

Map<String, dynamic> _$PriceDetachedItemOffToJson(
        PriceDetachedItemOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_price_detached_item_app': instance.id_price_detached_item_app,
      'id_price_detached': instance.id_price_detached,
      'id_price_detached_app': instance.id_price_detached_app,
      'id_price_detached_item_base': instance.id_price_detached_item_base,
      'price': instance.price,
      'tolerance': instance.tolerance,
    };
