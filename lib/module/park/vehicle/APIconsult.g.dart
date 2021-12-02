// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'APIconsult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIconsult _$APIconsultFromJson(Map<String, dynamic> json) {
  return APIconsult(
    ano: json['ano'] as String,
    anoModelo: json['anoModelo'] as String,
    chassi: json['chassi'] as String,
    codigoRetorno: json['codigoRetorno'] as String,
    codigoSituacao: json['codigoSituacao'] as String,
    cor: json['cor'] as String,
    data: json['data'] as String,
    dataAtualizacaoAlarme: json['dataAtualizacaoAlarme'] as String,
    dataAtualizacaoCaracteristicasVeiculo:
        json['dataAtualizacaoCaracteristicasVeiculo'] as String,
    dataAtualizacaoRouboFurto: json['dataAtualizacaoRouboFurto'] as String,
    marca: json['marca'] as String,
    mensagemRetorno: json['mensagemRetorno'] as String,
    modelo: json['modelo'] as String,
    municipio: json['municipio'] as String,
    placa: json['placa'] as String,
    situacao: json['situacao'] as String,
    uf: json['uf'] as String,
  );
}

Map<String, dynamic> _$APIconsultToJson(APIconsult instance) =>
    <String, dynamic>{
      'ano': instance.ano,
      'anoModelo': instance.anoModelo,
      'chassi': instance.chassi,
      'codigoRetorno': instance.codigoRetorno,
      'codigoSituacao': instance.codigoSituacao,
      'cor': instance.cor,
      'data': instance.data,
      'dataAtualizacaoAlarme': instance.dataAtualizacaoAlarme,
      'dataAtualizacaoCaracteristicasVeiculo':
          instance.dataAtualizacaoCaracteristicasVeiculo,
      'dataAtualizacaoRouboFurto': instance.dataAtualizacaoRouboFurto,
      'marca': instance.marca,
      'mensagemRetorno': instance.mensagemRetorno,
      'modelo': instance.modelo,
      'municipio': instance.municipio,
      'placa': instance.placa,
      'situacao': instance.situacao,
      'uf': instance.uf,
    };
