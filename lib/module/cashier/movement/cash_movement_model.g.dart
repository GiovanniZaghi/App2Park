// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashMovement _$CashMovementFromJson(Map<String, dynamic> json) {
  return CashMovement(
    id: json['id'] as String,
    id_cash: json['id_cash'] as String,
    id_ticket: json['id_ticket'] as String,
    id_agreement: json['id_agreement'] as String,
    id_agreement_app: json['id_agreement_app'] as String,
    id_cash_movement_app: json['id_cash_movement_app'] as String,
    id_ticket_app: json['id_ticket_app'] as String,
    date_added: json['date_added'] as String,
    id_cash_type_movement: json['id_cash_type_movement'] as String,
    id_payment_method: json['id_payment_method'] as String,
    id_price_detached: json['id_price_detached'] as String,
    id_price_detached_app: json['id_price_detached_app'] as String,
    value_initial: json['value_initial'] as String,
    value: json['value'] as String,
    comment: json['comment'] as String,
  );
}

Map<String, dynamic> _$CashMovementToJson(CashMovement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_cash': instance.id_cash,
      'id_ticket': instance.id_ticket,
      'id_agreement': instance.id_agreement,
      'id_agreement_app': instance.id_agreement_app,
      'id_cash_movement_app': instance.id_cash_movement_app,
      'id_ticket_app': instance.id_ticket_app,
      'date_added': instance.date_added,
      'id_cash_type_movement': instance.id_cash_type_movement,
      'id_payment_method': instance.id_payment_method,
      'id_price_detached': instance.id_price_detached,
      'id_price_detached_app': instance.id_price_detached_app,
      'value_initial': instance.value_initial,
      'value': instance.value,
      'comment': instance.comment,
    };
