import 'package:json_annotation/json_annotation.dart';

part 'cash_type_relatorio_model.g.dart';

@JsonSerializable()
class CashTypeRelatorioOff{
  int id;
  int id_cash_app;
  String date_added;
  int id_cash_type_movement;
  String name;
  String comment;
  String value;
  int id_ticket;
  int id_payment_method;
  String pagamento;

  CashTypeRelatorioOff(
      this.id,
      this.id_cash_app,
      this.date_added,
      this.id_cash_type_movement,
      this.name,
      this.comment,
      this.value,
      this.id_ticket,
      this.id_payment_method,
      this.pagamento);

  factory CashTypeRelatorioOff.fromJson(Map<String, dynamic> json) =>
      _$CashTypeRelatorioOffFromJson(json);

  Map<String, dynamic> toJson() => _$CashTypeRelatorioOffToJson(this);
}