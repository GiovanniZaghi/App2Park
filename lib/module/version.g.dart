// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Version _$VersionFromJson(Map<String, dynamic> json) {
  return Version(
    id: json['id'] as String,
    name: json['name'] as String,
    id_status: json['id_status'] as String,
  );
}

Map<String, dynamic> _$VersionToJson(Version instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'id_status': instance.id_status,
    };
