// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgreementResponse _$AgreementResponseFromJson(Map<String, dynamic> json) {
  return AgreementResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Agreements.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$AgreementResponseToJson(AgreementResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
