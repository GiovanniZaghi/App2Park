// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptResponse _$ReceiptResponseFromJson(Map<String, dynamic> json) {
  return ReceiptResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Receipt.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ReceiptResponseToJson(ReceiptResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
