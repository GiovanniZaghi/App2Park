// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_user_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkUserOff _$ParkUserOffFromJson(Map<String, dynamic> json) {
  return ParkUserOff(
    json['id'] as int,
    json['id_park'] as int,
    json['id_user'] as int,
    json['id_office'] as int,
    json['id_status'] as int,
    json['keyval'] as String,
    json['date_added'] as String,
    json['date_edited'] as String,
  );
}

Map<String, dynamic> _$ParkUserOffToJson(ParkUserOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_park': instance.id_park,
      'id_user': instance.id_user,
      'id_office': instance.id_office,
      'id_status': instance.id_status,
      'keyval': instance.keyval,
      'date_added': instance.date_added,
      'date_edited': instance.date_edited,
    };
