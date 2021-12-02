// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogResponse _$LogResponseFromJson(Map<String, dynamic> json) {
  return LogResponse(
    status: json['status'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$LogResponseToJson(LogResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
