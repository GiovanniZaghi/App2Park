// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_off.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptOff _$ReceiptOffFromJson(Map<String, dynamic> json) {
  return ReceiptOff(
    json['id'] as String,
    json['id_ticket_app'] as int,
    json['id_ticket'] as String,
    json['id_cupom'] as String,
    json['res'] as String,
  )..id_receipt_app = json['id_receipt_app'] as int;
}

Map<String, dynamic> _$ReceiptOffToJson(ReceiptOff instance) =>
    <String, dynamic>{
      'id_receipt_app': instance.id_receipt_app,
      'id': instance.id,
      'id_ticket_app': instance.id_ticket_app,
      'id_ticket': instance.id_ticket,
      'id_cupom': instance.id_cupom,
      'res': instance.res,
    };
