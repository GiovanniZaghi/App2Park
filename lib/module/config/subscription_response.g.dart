// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionResponse _$SubscriptionResponseFromJson(Map<String, dynamic> json) {
  return SubscriptionResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SubscriptionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SubscriptionResponseToJson(
        SubscriptionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
