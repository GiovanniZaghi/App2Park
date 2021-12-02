// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedItemResponse _$PriceDetachedItemResponseFromJson(
    Map<String, dynamic> json) {
  return PriceDetachedItemResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PriceDetachedItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$PriceDetachedItemResponseToJson(
        PriceDetachedItemResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
