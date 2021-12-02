// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashTypeResponse _$CashTypeResponseFromJson(Map<String, dynamic> json) {
  return CashTypeResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CashTypeMovement.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CashTypeResponseToJson(CashTypeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
