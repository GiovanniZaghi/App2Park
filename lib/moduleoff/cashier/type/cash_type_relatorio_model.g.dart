// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_type_relatorio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashTypeRelatorioOff _$CashTypeRelatorioOffFromJson(Map<String, dynamic> json) {
  return CashTypeRelatorioOff(
    json['id'] as int,
    json['id_cash_app'] as int,
    json['date_added'] as String,
    json['id_cash_type_movement'] as int,
    json['name'] as String,
    json['comment'] as String,
    json['value'] as String,
    json['id_ticket'] as int,
    json['id_payment_method'] as int,
    json['pagamento'] as String,
  );
}

Map<String, dynamic> _$CashTypeRelatorioOffToJson(
        CashTypeRelatorioOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_cash_app': instance.id_cash_app,
      'date_added': instance.date_added,
      'id_cash_type_movement': instance.id_cash_type_movement,
      'name': instance.name,
      'comment': instance.comment,
      'value': instance.value,
      'id_ticket': instance.id_ticket,
      'id_payment_method': instance.id_payment_method,
      'pagamento': instance.pagamento,
    };
