import 'package:json_annotation/json_annotation.dart';

part 'cash_type_movement_inner_off_model.g.dart';

@JsonSerializable()
class CashTypeMovementInnerOff{
  int id_cash_app;
  int id_user;
  String first_name;
  String last_name;
  String abertura;
  String fechamento;


  CashTypeMovementInnerOff(this.id_cash_app, this.id_user, this.first_name,
      this.last_name, this.abertura, this.fechamento);

  factory CashTypeMovementInnerOff.fromJson(Map<String, dynamic> json) =>
      _$CashTypeMovementInnerOffFromJson(json);

  Map<String, dynamic> toJson() => _$CashTypeMovementInnerOffToJson(this);
}