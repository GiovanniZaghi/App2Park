// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_inner_join_payment_method_park_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodInnerJoinPaymentMethodPark
    _$PaymentMethodInnerJoinPaymentMethodParkFromJson(
        Map<String, dynamic> json) {
  return PaymentMethodInnerJoinPaymentMethodPark(
    name: json['name'] as String,
    st: json['st'] as String,
    id: json['id'] as int,
    id_park: json['id_park'] as int,
    id_payment_method: json['id_payment_method'] as int,
    flat_rate: (json['flat_rate'] as num)?.toDouble(),
    variable_rate: (json['variable_rate'] as num)?.toDouble(),
    min_value: (json['min_value'] as num)?.toDouble(),
    status: json['status'] as int,
    sort_order: json['sort_order'] as int,
  );
}

Map<String, dynamic> _$PaymentMethodInnerJoinPaymentMethodParkToJson(
        PaymentMethodInnerJoinPaymentMethodPark instance) =>
    <String, dynamic>{
      'name': instance.name,
      'st': instance.st,
      'id': instance.id,
      'id_park': instance.id_park,
      'id_payment_method': instance.id_payment_method,
      'flat_rate': instance.flat_rate,
      'variable_rate': instance.variable_rate,
      'min_value': instance.min_value,
      'status': instance.status,
      'sort_order': instance.sort_order,
    };
