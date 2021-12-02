// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgreementListResponse _$AgreementListResponseFromJson(
    Map<String, dynamic> json) {
  return AgreementListResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Agreements.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$AgreementListResponseToJson(
        AgreementListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
