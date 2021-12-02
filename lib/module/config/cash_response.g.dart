// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashResponse _$CashResponseFromJson(Map<String, dynamic> json) {
  return CashResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Cashs.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CashResponseToJson(CashResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
