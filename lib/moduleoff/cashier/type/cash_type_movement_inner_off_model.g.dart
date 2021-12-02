// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_type_movement_inner_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashTypeMovementInnerOff _$CashTypeMovementInnerOffFromJson(
    Map<String, dynamic> json) {
  return CashTypeMovementInnerOff(
    json['id_cash_app'] as int,
    json['id_user'] as int,
    json['first_name'] as String,
    json['last_name'] as String,
    json['abertura'] as String,
    json['fechamento'] as String,
  );
}

Map<String, dynamic> _$CashTypeMovementInnerOffToJson(
        CashTypeMovementInnerOff instance) =>
    <String, dynamic>{
      'id_cash_app': instance.id_cash_app,
      'id_user': instance.id_user,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'abertura': instance.abertura,
      'fechamento': instance.fechamento,
    };
