// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) {
  return CartItemModel(
    id: json['id'] as String,
    id_cart: json['id_cart'] as String,
    id_park: json['id_park'] as String,
    id_period: json['id_period'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_cart': instance.id_cart,
      'id_park': instance.id_park,
      'id_period': instance.id_period,
      'value': instance.value,
    };
