// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemOffModel _$CartItemOffModelFromJson(Map<String, dynamic> json) {
  return CartItemOffModel(
    json['id'] as int,
    json['id_cart'] as int,
    json['id_park'] as int,
    json['id_period'] as int,
    (json['value'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CartItemOffModelToJson(CartItemOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_cart': instance.id_cart,
      'id_park': instance.id_park,
      'id_period': instance.id_period,
      'value': instance.value,
    };
