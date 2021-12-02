// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map<String, dynamic> json) {
  return Receipt(
    id_ticket: json['id_ticket'] as String,
    id_cupom: json['id_cupom'] as String,
    res: json['res'] as String,
  );
}

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id_ticket': instance.id_ticket,
      'id_cupom': instance.id_cupom,
      'res': instance.res,
    };
