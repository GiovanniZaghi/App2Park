// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) {
  return CartResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : CartModel.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
