// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkListResponse _$ParkListResponseFromJson(Map<String, dynamic> json) {
  return ParkListResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Park.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ParkListResponseToJson(ParkListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
