// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserJwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJwt _$UserJwtFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['jwt']);
  return UserJwt(
    id: json['id'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    cell: json['cell'] as String,
    doc: json['doc'] as String,
    email: json['email'] as String,
    pass: json['pass'] as String,
    id_status: json['id_status'] as String,
    jwt: json['jwt'] as String,
  );
}

Map<String, dynamic> _$UserJwtToJson(UserJwt instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'cell': instance.cell,
      'doc': instance.doc,
      'email': instance.email,
      'pass': instance.pass,
      'id_status': instance.id_status,
      'jwt': instance.jwt,
    };
