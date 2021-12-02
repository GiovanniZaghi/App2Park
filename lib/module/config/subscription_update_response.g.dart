// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionUpdateResponse _$SubscriptionUpdateResponseFromJson(
    Map<String, dynamic> json) {
  return SubscriptionUpdateResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Park.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SubscriptionUpdateResponseToJson(
        SubscriptionUpdateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
