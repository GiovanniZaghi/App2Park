// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionOffModel _$SubscriptionOffModelFromJson(Map<String, dynamic> json) {
  return SubscriptionOffModel(
    json['id'] as int,
    json['id_user'] as int,
    (json['subscription_price'] as num)?.toDouble(),
    json['id_period'] as int,
    json['id_send'] as int,
    json['doc'] as String,
    json['name'] as String,
    json['email'] as String,
    json['postal_code'] as String,
    json['street'] as String,
    json['number'] as String,
    json['complement'] as String,
    json['neighborhood'] as String,
    json['city'] as String,
    json['state'] as String,
    json['ddd'] as String,
    json['cell'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$SubscriptionOffModelToJson(
        SubscriptionOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_user': instance.id_user,
      'subscription_price': instance.subscription_price,
      'id_period': instance.id_period,
      'id_send': instance.id_send,
      'doc': instance.doc,
      'name': instance.name,
      'email': instance.email,
      'postal_code': instance.postal_code,
      'street': instance.street,
      'number': instance.number,
      'complement': instance.complement,
      'neighborhood': instance.neighborhood,
      'city': instance.city,
      'state': instance.state,
      'ddd': instance.ddd,
      'cell': instance.cell,
      'type': instance.type,
    };
