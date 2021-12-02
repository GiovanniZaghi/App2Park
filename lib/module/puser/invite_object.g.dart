// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteObject _$InviteObjectFromJson(Map<String, dynamic> json) {
  return InviteObject(
    email: json['email'] as String,
    id_park: json['id_park'] as String,
    id_office: json['id_office'] as String,
    cell: json['cell'] as String,
    first_name: json['first_name'] as String,
    id_user: json['id_user'] as String,
  );
}

Map<String, dynamic> _$InviteObjectToJson(InviteObject instance) =>
    <String, dynamic>{
      'email': instance.email,
      'id_park': instance.id_park,
      'id_office': instance.id_office,
      'cell': instance.cell,
      'first_name': instance.first_name,
      'id_user': instance.id_user,
    };
