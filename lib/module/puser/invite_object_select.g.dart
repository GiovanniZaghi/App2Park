// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_object_select.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteObjectSelect _$InviteObjectSelectFromJson(Map<String, dynamic> json) {
  return InviteObjectSelect(
    json['id'] as int,
    json['id_office'] as int,
    json['id_user'] as int,
    json['id_park'] as int,
    json['id_status'] as int,
    json['cell'] as String,
    json['email'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['office'] as String,
  );
}

Map<String, dynamic> _$InviteObjectSelectToJson(InviteObjectSelect instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_office': instance.id_office,
      'id_user': instance.id_user,
      'id_park': instance.id_park,
      'id_status': instance.id_status,
      'cell': instance.cell,
      'email': instance.email,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'office': instance.office,
    };
