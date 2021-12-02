// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusResponse _$StatusResponseFromJson(Map<String, dynamic> json) {
  return StatusResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Status.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$StatusResponseToJson(StatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
