// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleResponse _$SimpleResponseFromJson(Map<String, dynamic> json) {
  return SimpleResponse(
    status: json['status'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SimpleResponseToJson(SimpleResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
