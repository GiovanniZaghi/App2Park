// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boleto_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoletoResponse _$BoletoResponseFromJson(Map<String, dynamic> json) {
  return BoletoResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : BoletoGet.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$BoletoResponseToJson(BoletoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
