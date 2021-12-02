// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedItem _$PriceDetachedItemFromJson(Map<String, dynamic> json) {
  return PriceDetachedItem(
    id: json['id'] as String,
    id_price_detached_item_app: json['id_price_detached_item_app'] as String,
    id_price_detached: json['id_price_detached'] as String,
    id_price_detached_item_base: json['id_price_detached_item_base'] as String,
    price: json['price'] as String,
    tolerance: json['tolerance'] as String,
  );
}

Map<String, dynamic> _$PriceDetachedItemToJson(PriceDetachedItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_price_detached_item_app': instance.id_price_detached_item_app,
      'id_price_detached': instance.id_price_detached,
      'id_price_detached_item_base': instance.id_price_detached_item_base,
      'price': instance.price,
      'tolerance': instance.tolerance,
    };
