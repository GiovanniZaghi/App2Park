// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extrato.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Extrato _$ExtratoFromJson(Map<String, dynamic> json) {
  return Extrato(
    nome: json['nome'] as String,
    quantidade: json['quantidade'] as int,
    preco: (json['preco'] as num)?.toDouble(),
    tempo: json['tempo'],
    tolerancia: json['tolerancia'],
    tempoYear: json['tempoYear'] as int,
    tempoMonth: json['tempoMonth'] as int,
    tempoDay: json['tempoDay'] as int,
    tempoHour: json['tempoHour'] as int,
    tempoMinute: json['tempoMinute'] as int,
    tempoSecond: json['tempoSecond'] as int,
    toleranciaHour: json['toleranciaHour'] as int,
    toleranciaMinute: json['toleranciaMinute'] as int,
    toleranciaSecond: json['toleranciaSecond'] as int,
  );
}

Map<String, dynamic> _$ExtratoToJson(Extrato instance) => <String, dynamic>{
      'nome': instance.nome,
      'quantidade': instance.quantidade,
      'preco': instance.preco,
      'tempo': instance.tempo,
      'tolerancia': instance.tolerancia,
      'tempoYear': instance.tempoYear,
      'tempoMonth': instance.tempoMonth,
      'tempoDay': instance.tempoDay,
      'tempoHour': instance.tempoHour,
      'tempoMinute': instance.tempoMinute,
      'tempoSecond': instance.tempoSecond,
      'toleranciaHour': instance.toleranciaHour,
      'toleranciaMinute': instance.toleranciaMinute,
      'toleranciaSecond': instance.toleranciaSecond,
    };
