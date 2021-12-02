
import 'package:json_annotation/json_annotation.dart';

part 'APIconsult.g.dart';

@JsonSerializable()
class APIconsult{
  String ano;
  String anoModelo;
  String chassi;
  String codigoRetorno;
  String codigoSituacao;
  String cor;
  String data;
  String dataAtualizacaoAlarme;
  String dataAtualizacaoCaracteristicasVeiculo;
  String dataAtualizacaoRouboFurto;
  String marca;
  String mensagemRetorno;
  String modelo;
  String municipio;
  String placa;
  String situacao;
  String uf;

  APIconsult({this.ano, this.anoModelo, this.chassi, this.codigoRetorno,
      this.codigoSituacao, this.cor, this.data, this.dataAtualizacaoAlarme,
      this.dataAtualizacaoCaracteristicasVeiculo,
      this.dataAtualizacaoRouboFurto, this.marca, this.mensagemRetorno,
      this.modelo, this.municipio, this.placa, this.situacao, this.uf});

  factory APIconsult.fromJson(Map<String, dynamic> json) => _$APIconsultFromJson(json);

  Map<String, dynamic> toJson() => _$APIconsultToJson(this);


}