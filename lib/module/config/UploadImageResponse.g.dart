// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UploadImageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImageResponse _$UploadImageResponseFromJson(Map<String, dynamic> json) {
  return UploadImageResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Park.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$UploadImageResponseToJson(
        UploadImageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
