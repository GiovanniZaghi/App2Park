// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_off.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogOff _$LogOffFromJson(Map<String, dynamic> json) {
  return LogOff(
    json['id'] as String,
    json['id_user'] as String,
    json['id_park'] as String,
    json['error'] as String,
    json['version'] as String,
    json['created'] as String,
    json['screen_error'] as String,
    json['platform'] as String,
  )..id_mob = json['id_mob'] as int;
}

Map<String, dynamic> _$LogOffToJson(LogOff instance) => <String, dynamic>{
      'id_mob': instance.id_mob,
      'id': instance.id,
      'id_user': instance.id_user,
      'id_park': instance.id_park,
      'error': instance.error,
      'version': instance.version,
      'created': instance.created,
      'screen_error': instance.screen_error,
      'platform': instance.platform,
    };
