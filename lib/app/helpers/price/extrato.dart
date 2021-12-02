import 'package:json_annotation/json_annotation.dart';

part 'extrato.g.dart';

@JsonSerializable()
class Extrato {
  String nome;
  int quantidade;
  double preco;
  var tempo;
  var tolerancia;
  int tempoYear;
  int tempoMonth;
  int tempoDay;
  int tempoHour;
  int tempoMinute;
  int tempoSecond;
  int toleranciaHour;
  int toleranciaMinute;
  int toleranciaSecond;


  Extrato({
      this.nome,
      this.quantidade,
      this.preco,
      this.tempo,
      this.tolerancia,
      this.tempoYear,
      this.tempoMonth,
      this.tempoDay,
      this.tempoHour,
      this.tempoMinute,
      this.tempoSecond,
      this.toleranciaHour,
      this.toleranciaMinute,
      this.toleranciaSecond});

  factory Extrato.fromJson(Map<String, dynamic> json) => _$ExtratoFromJson(json);

  Map<String, dynamic> toJson() => _$ExtratoToJson(this);

  @override
  String toString() {
    return '{nome: $nome, quantidade: $quantidade, preco: $preco, tempo: $tempo, tolerancia: $tolerancia, tempoYear: $tempoYear, tempoMonth: $tempoMonth, tempoDay: $tempoDay, tempoHour: $tempoHour, tempoMinute: $tempoMinute, tempoSecond: $tempoSecond, toleranciaHour: $toleranciaHour, toleranciaMinute: $toleranciaMinute, toleranciaSecond: $toleranciaSecond}';
  }
}