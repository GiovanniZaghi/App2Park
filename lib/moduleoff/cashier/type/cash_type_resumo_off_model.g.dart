// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_type_resumo_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashTypeResumoOff _$CashTypeResumoOffFromJson(Map<String, dynamic> json) {
  return CashTypeResumoOff(
    json['id_cash_type_movement'] as int,
    json['name'] as String,
    json['id_payment_method'] as int,
    json['pagamento'] as String,
    (json['value'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CashTypeResumoOffToJson(CashTypeResumoOff instance) =>
    <String, dynamic>{
      'id_cash_type_movement': instance.id_cash_type_movement,
      'name': instance.name,
      'id_payment_method': instance.id_payment_method,
      'pagamento': instance.pagamento,
      'value': instance.value,
    };
