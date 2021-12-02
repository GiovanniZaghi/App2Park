// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_send.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptSend _$ReceiptSendFromJson(Map<String, dynamic> json) {
  return ReceiptSend(
    id: json['id'] as String,
    name_park: json['name_park'] as String,
    doc: json['doc'] as String,
    street: json['street'] as String,
    number: json['number'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    plate: json['plate'] as String,
    model: json['model'] as String,
    data_ent: json['data_ent'] as String,
    data_sai: json['data_sai'] as String,
    exitserviceAdittionalList: json['exitserviceAdittionalList'] as String,
    eList: json['eList'] as String,
    total: json['total'] as String,
    taxa: json['taxa'] as String,
    desconto: json['desconto'] as String,
    total_pago: json['total_pago'] as String,
  );
}

Map<String, dynamic> _$ReceiptSendToJson(ReceiptSend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_park': instance.name_park,
      'doc': instance.doc,
      'street': instance.street,
      'number': instance.number,
      'city': instance.city,
      'state': instance.state,
      'plate': instance.plate,
      'model': instance.model,
      'data_ent': instance.data_ent,
      'data_sai': instance.data_sai,
      'exitserviceAdittionalList': instance.exitserviceAdittionalList,
      'eList': instance.eList,
      'total': instance.total,
      'taxa': instance.taxa,
      'desconto': instance.desconto,
      'total_pago': instance.total_pago,
    };
