// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_movement_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashMovementOff _$CashMovementOffFromJson(Map<String, dynamic> json) {
  return CashMovementOff(
    json['id'] as int,
    json['id_cash'] as int,
    json['id_cash_app'] as int,
    json['id_ticket'] as int,
    json['id_ticket_app'] as int,
    json['id_agreement'] as int,
    json['id_agreement_app'] as int,
    json['date_added'] as String,
    json['id_cash_type_movement'] as int,
    json['id_payment_method'] as int,
    json['id_price_detached'] as int,
    json['id_price_detached_app'] as int,
    json['value_initial'] as String,
    json['value'] as String,
    json['comment'] as String,
  )..id_cash_movement_app = json['id_cash_movement_app'] as int;
}

Map<String, dynamic> _$CashMovementOffToJson(CashMovementOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_cash': instance.id_cash,
      'id_cash_app': instance.id_cash_app,
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
