// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'park_service_additional_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkServiceAdditionalResponse _$ParkServiceAdditionalResponseFromJson(
    Map<String, dynamic> json) {
  return ParkServiceAdditionalResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ParkServiceAdditional.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ParkServiceAdditionalResponseToJson(
        ParkServiceAdditionalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
