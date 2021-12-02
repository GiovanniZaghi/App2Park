// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeResponse _$OfficeResponseFromJson(Map<String, dynamic> json) {
  return OfficeResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Office.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$OfficeResponseToJson(OfficeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
