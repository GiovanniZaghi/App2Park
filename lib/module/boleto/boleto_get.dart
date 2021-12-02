import 'package:json_annotation/json_annotation.dart';
part 'boleto_get.g.dart';

@JsonSerializable()
class BoletoGet{
  String seuNumero;
  String nossoNumero;
  String codigoBarras;
  String linhaDigitavel;
  String criacao;
  String valor;
  String vencimento;

  BoletoGet(
      {this.seuNumero, this.nossoNumero, this.codigoBarras, this.linhaDigitavel, this.criacao, this.valor, this.vencimento});

  factory BoletoGet.fromJson(Map<String, dynamic> json) => _$BoletoGetFromJson(json);

  Map<String, dynamic> toJson() => _$BoletoGetToJson(this);
}