// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionItemModel _$SubscriptionItemModelFromJson(
    Map<String, dynamic> json) {
  return SubscriptionItemModel(
    id: json['id'] as String,
    id_subscription: json['id_subscription'] as String,
    id_park: json['id_park'] as String,
  );
}

Map<String, dynamic> _$SubscriptionItemModelToJson(
        SubscriptionItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_subscription': instance.id_subscription,
      'id_park': instance.id_park,
    };
