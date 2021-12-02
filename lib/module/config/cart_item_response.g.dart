// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemResponse _$CartItemResponseFromJson(Map<String, dynamic> json) {
  return CartItemResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : CartItemModel.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CartItemResponseToJson(CartItemResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
