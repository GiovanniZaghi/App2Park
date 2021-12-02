// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) {
  return Log(
    id_user: json['id_user'] as String,
    id_park: json['id_park'] as String,
    error: json['error'] as String,
    version: json['version'] as String,
    created: json['created'] as String,
    screen_error: json['screen_error'] as String,
    platform: json['platform'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'id': instance.id,
      'id_user': instance.id_user,
      'id_park': instance.id_park,
      'error': instance.error,
      'version': instance.version,
      'created': instance.created,
      'screen_error': instance.screen_error,
      'platform': instance.platform,
    };
