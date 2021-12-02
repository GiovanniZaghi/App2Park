// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_item_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionItemOffModel _$SubscriptionItemOffModelFromJson(
    Map<String, dynamic> json) {
  return SubscriptionItemOffModel(
    json['id'] as int,
    json['id_subscription'] as int,
    json['id_park'] as int,
  );
}

Map<String, dynamic> _$SubscriptionItemOffModelToJson(
        SubscriptionItemOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_subscription': instance.id_subscription,
      'id_park': instance.id_park,
    };
