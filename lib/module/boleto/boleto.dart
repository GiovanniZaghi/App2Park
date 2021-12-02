import 'package:json_annotation/json_annotation.dart';
part 'boleto.g.dart';

@JsonSerializable()
class Boleto{
  String doc;
  String name;
  String email;
  String cell;
  String postal_code;
  String number;
  String complement;
  String neighborhood;
  String city;
  String state;
  String street;
  String ddd;
  String type;
  String vencimento;
  String valor;

  Boleto(
    {  this.doc,
      this.name,
      this.email,
      this.cell,
      this.postal_code,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state,
      this.street,
      this.ddd,
      this.type,
      this.vencimento,
      this.valor});

  factory Boleto.fromJson(Map<String, dynamic> json) => _$BoletoFromJson(json);

  Map<String, dynamic> toJson() => _$BoletoToJson(this);
}