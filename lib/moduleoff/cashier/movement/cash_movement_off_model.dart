import 'package:json_annotation/json_annotation.dart';

part 'cash_movement_off_model.g.dart';

@JsonSerializable()
class CashMovementOff{
  int id;
  int id_cash;
  int id_cash_app;
  int id_ticket;
  int id_agreement;
  int id_agreement_app;
  int id_cash_movement_app;
  int id_ticket_app;
  String date_added;
  int id_cash_type_movement;
  int id_payment_method;
  int id_price_detached;
  int id_price_detached_app;
  String value_initial;
  String value;
  String comment;


  CashMovementOff(
      this.id,
      this.id_cash,
      this.id_cash_app,
      this.id_ticket,
      this.id_ticket_app,
      this.id_agreement,
      this.id_agreement_app,
      this.date_added,
      this.id_cash_type_movement,
      this.id_payment_method,
      this.id_price_detached,
      this.id_price_detached_app,
      this.value_initial,
      this.value,
      this.comment);

  factory CashMovementOff.fromJson(Map<String, dynamic> json) =>
      _$CashMovementOffFromJson(json);

  Map<String, dynamic> toJson() => _$CashMovementOffToJson(this);

  @override
  String toString() {
    return 'CashMovementOff{id: $id, id_cash: $id_cash, id_cash_app: $id_cash_app, id_ticket: $id_ticket, id_cash_movement_app: $id_cash_movement_app, id_ticket_app: $id_ticket_app, date_added: $date_added, id_cash_type_movement: $id_cash_type_movement, id_payment_method: $id_payment_method, value: $value, comment: $comment}';
  }
}