// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_money_graphics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardMoneyGraphics _$DashboardMoneyGraphicsFromJson(
    Map<String, dynamic> json) {
  return DashboardMoneyGraphics(
    id: json['id'] as int,
    tipo: json['tipo'] as String,
    pagamento: json['pagamento'] as String,
    value: (json['value'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DashboardMoneyGraphicsToJson(
        DashboardMoneyGraphics instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tipo': instance.tipo,
      'pagamento': instance.pagamento,
      'value': instance.value,
    };
