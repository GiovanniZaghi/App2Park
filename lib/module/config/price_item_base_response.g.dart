// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_item_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceItemBaseResponse _$PriceItemBaseResponseFromJson(
    Map<String, dynamic> json) {
  return PriceItemBaseResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PriceDetachedBase.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$PriceItemBaseResponseToJson(
        PriceItemBaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
