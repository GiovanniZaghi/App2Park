// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkUser _$ParkUserFromJson(Map<String, dynamic> json) {
  return ParkUser(
    id: json['id'] as String,
    id_park: json['id_park'] as String,
    id_user: json['id_user'] as String,
    id_office: json['id_office'] as String,
    id_status: json['id_status'] as String,
    keyval: json['keyval'] as String,
    date_added: json['date_added'] as String,
    date_edited: json['date_edited'] as String,
  );
}

Map<String, dynamic> _$ParkUserToJson(ParkUser instance) => <String, dynamic>{
      'id': instance.id,
      'id_park': instance.id_park,
      'id_user': instance.id_user,
      'id_office': instance.id_office,
      'id_status': instance.id_status,
      'keyval': instance.keyval,
      'date_added': instance.date_added,
      'date_edited': instance.date_edited,
    };
