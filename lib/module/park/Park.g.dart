// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Park.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Park _$ParkFromJson(Map<String, dynamic> json) {
  return Park(
    id: json['id'] as String,
    type: json['type'] as String,
    doc: json['doc'] as String,
    name_park: json['name_park'] as String,
    business_name: json['business_name'] as String,
    cell: json['cell'] as String,
    photo: json['photo'] as String,
    postal_code: json['postal_code'] as String,
    street: json['street'] as String,
    number: json['number'] as String,
    complement: json['complement'] as String,
    neighborhood: json['neighborhood'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    country: json['country'] as String,
    vacancy: json['vacancy'] as String,
    subscription: json['subscription'] as String,
    id_status: json['id_status'] as String,
    date_added: json['date_added'] as String,
    date_edited: json['date_edited'] as String,
  );
}

Map<String, dynamic> _$ParkToJson(Park instance) => <String, dynamic>{
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
