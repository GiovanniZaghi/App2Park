// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    id: json['id'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
    };
