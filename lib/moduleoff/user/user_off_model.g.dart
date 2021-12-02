// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOff _$UserOffFromJson(Map<String, dynamic> json) {
  return UserOff(
    json['id'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['cell'] as String,
    json['doc'] as String,
    json['email'] as String,
    json['pass'] as String,
    json['id_status'] as String,
  );
}

Map<String, dynamic> _$UserOffToJson(UserOff instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'cell': instance.cell,
      'doc': instance.doc,
      'email': instance.email,
      'pass': instance.pass,
      'id_status': instance.id_status,
    };
