// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedResponse _$PriceDetachedResponseFromJson(
    Map<String, dynamic> json) {
  return PriceDetachedResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PriceDetached.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$PriceDetachedResponseToJson(
        PriceDetachedResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
