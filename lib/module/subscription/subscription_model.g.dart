// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) {
  return SubscriptionModel(
    id: json['id'] as String,
    id_user: json['id_user'] as String,
    subscription_price: json['subscription_price'] as String,
    id_period: json['id_period'] as String,
    id_send: json['id_send'] as String,
    doc: json['doc'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    postal_code: json['postal_code'] as String,
    street: json['street'] as String,
    number: json['number'] as String,
    complement: json['complement'] as String,
    neighborhood: json['neighborhood'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    ddd: json['ddd'] as String,
    cell: json['cell'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
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
