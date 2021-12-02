import 'package:json_annotation/json_annotation.dart';

part 'cash_type_resumo_off_model.g.dart';

@JsonSerializable()
class CashTypeResumoOff{
  int id_cash_type_movement;
  String name;
  int id_payment_method;
  String pagamento;
  double value;


  CashTypeResumoOff(this.id_cash_type_movement, this.name,
      this.id_payment_method, this.pagamento, this.value);

  factory CashTypeResumoOff.fromJson(Map<String, dynamic> json) =>
      _$CashTypeResumoOffFromJson(json);

  Map<String, dynamic> toJson() => _$CashTypeResumoOffToJson(this);
}