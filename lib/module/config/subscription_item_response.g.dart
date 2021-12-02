// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionItemResponse _$SubscriptionItemResponseFromJson(
    Map<String, dynamic> json) {
  return SubscriptionItemResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SubscriptionItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SubscriptionItemResponseToJson(
        SubscriptionItemResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
