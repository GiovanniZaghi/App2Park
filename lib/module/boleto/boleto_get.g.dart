// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boleto_get.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoletoGet _$BoletoGetFromJson(Map<String, dynamic> json) {
  return BoletoGet(
    seuNumero: json['seuNumero'] as String,
    nossoNumero: json['nossoNumero'] as String,
    codigoBarras: json['codigoBarras'] as String,
    linhaDigitavel: json['linhaDigitavel'] as String,
    criacao: json['criacao'] as String,
    valor: json['valor'] as String,
    vencimento: json['vencimento'] as String,
  );
}

Map<String, dynamic> _$BoletoGetToJson(BoletoGet instance) => <String, dynamic>{
      'seuNumero': instance.seuNumero,
      'nossoNumero': instance.nossoNumero,
      'codigoBarras': instance.codigoBarras,
      'linhaDigitavel': instance.linhaDigitavel,
      'criacao': instance.criacao,
      'valor': instance.valor,
      'vencimento': instance.vencimento,
    };
