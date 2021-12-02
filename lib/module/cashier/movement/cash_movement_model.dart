import 'package:json_annotation/json_annotation.dart';

part 'cash_movement_model.g.dart';

@JsonSerializable()
class CashMovement{
  String id;
  String id_cash;
  String id_ticket;
  String id_agreement;
  String id_agreement_app;
  String id_cash_movement_app;
  String id_ticket_app;
  String date_added;
  String id_cash_type_movement;
  String id_payment_method;
  String id_price_detached;
  String id_price_detached_app;
  String value_initial;
  String value;
  String comment;


  CashMovement({
      this.id,
      this.id_cash,
      this.id_ticket,
      this.id_agreement,
      this.id_agreement_app,
      this.id_cash_movement_app,
      this.id_ticket_app,
      this.date_added,
      this.id_cash_type_movement,
      this.id_payment_method,
      this.id_price_detached,
      this.id_price_detached_app,
      this.value_initial,
      this.value,
      this.comment});

  factory CashMovement.fromJson(Map<String, dynamic> json) =>
      _$CashMovementFromJson(json);

  Map<String, dynamic> toJson() => _$CashMovementToJson(this);
}