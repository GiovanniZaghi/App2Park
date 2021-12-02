// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParkOff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkOff _$ParkOffFromJson(Map<String, dynamic> json) {
  return ParkOff(
    json['id'] as String,
    json['type'] as String,
    json['doc'] as String,
    json['name_park'] as String,
    json['business_name'] as String,
    json['cell'] as String,
    json['photo'] as String,
    json['postal_code'] as String,
    json['street'] as String,
    json['number'] as String,
    json['complement'] as String,
    json['neighborhood'] as String,
    json['city'] as String,
    json['state'] as String,
    json['country'] as String,
    json['vacancy'] as String,
    json['subscription'] as String,
    json['id_status'] as String,
    json['date_added'] as String,
    json['date_edited'] as String,
  );
}

Map<String, dynamic> _$ParkOffToJson(ParkOff instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'doc': instance.doc,
      'name_park': instance.name_park,
      'business_name': instance.business_name,
      'cell': instance.cell,
      'photo': instance.photo,
      'postal_code': instance.postal_code,
      'street': instance.street,
      'number': instance.number,
      'complement': instance.complement,
      'neighborhood': instance.neighborhood,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'vacancy': instance.vacancy,
      'subscription': instance.subscription,
      'id_status': instance.id_status,
      'date_added': instance.date_added,
      'date_edited': instance.date_edited,
    };
