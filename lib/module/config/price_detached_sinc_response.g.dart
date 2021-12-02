// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_detached_sinc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDetachedSincResponse _$PriceDetachedSincResponseFromJson(
    Map<String, dynamic> json) {
  return PriceDetachedSincResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PriceDetached.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    mode: json['mode'] as String,
  );
}

Map<String, dynamic> _$PriceDetachedSincResponseToJson(
        PriceDetachedSincResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
      'mode': instance.mode,
    };
