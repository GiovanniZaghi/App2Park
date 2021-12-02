// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParkJwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkJwt _$ParkJwtFromJson(Map<String, dynamic> json) {
  return ParkJwt(
    id: json['id'] as String,
    type: json['type'] as String,
    doc: json['doc'] as String,
    name_park: json['name_park'] as String,
    business_name: json['business_name'] as String,
    cell: json['cell'] as String,
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
    jwt: json['jwt'] as String,
    date_added: json['date_added'] as String,
    id_user: json['id_user'] as String,
  )..photo = json['photo'] as String;
}

Map<String, dynamic> _$ParkJwtToJson(ParkJwt instance) => <String, dynamic>{
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
      'jwt': instance.jwt,
      'date_added': instance.date_added,
      'id_user': instance.id_user,
    };
