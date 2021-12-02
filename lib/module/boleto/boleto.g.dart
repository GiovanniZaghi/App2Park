// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boleto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Boleto _$BoletoFromJson(Map<String, dynamic> json) {
  return Boleto(
    doc: json['doc'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    cell: json['cell'] as String,
    postal_code: json['postal_code'] as String,
    number: json['number'] as String,
    complement: json['complement'] as String,
    neighborhood: json['neighborhood'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    street: json['street'] as String,
    ddd: json['ddd'] as String,
    type: json['type'] as String,
    vencimento: json['vencimento'] as String,
    valor: json['valor'] as String,
  );
}

Map<String, dynamic> _$BoletoToJson(Boleto instance) => <String, dynamic>{
      'doc': instance.doc,
      'name': instance.name,
      'email': instance.email,
      'cell': instance.cell,
      'postal_code': instance.postal_code,
      'number': instance.number,
      'complement': instance.complement,
      'neighborhood': instance.neighborhood,
      'city': instance.city,
      'state': instance.state,
      'street': instance.street,
      'ddd': instance.ddd,
      'type': instance.type,
      'vencimento': instance.vencimento,
      'valor': instance.valor,
    };
