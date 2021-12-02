// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_additional_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceAdditionalResponse _$ServiceAdditionalResponseFromJson(
    Map<String, dynamic> json) {
  return ServiceAdditionalResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ServiceAdditionalModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ServiceAdditionalResponseToJson(
        ServiceAdditionalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
