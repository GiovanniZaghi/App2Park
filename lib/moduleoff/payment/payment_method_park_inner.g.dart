// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_park_inner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodParkInner _$PaymentMethodParkInnerFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodParkInner(
    json['id'] as int,
    json['id_park'] as int,
    json['id_payment_method'] as int,
    (json['flat_rate'] as num)?.toDouble(),
    (json['variable_rate'] as num)?.toDouble(),
    (json['min_value'] as num)?.toDouble(),
    json['id_status'] as int,
    json['sort_order'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodParkInnerToJson(
        PaymentMethodParkInner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_park': instance.id_park,
      'id_payment_method': instance.id_payment_method,
      'flat_rate': instance.flat_rate,
      'variable_rate': instance.variable_rate,
      'min_value': instance.min_value,
      'id_status': instance.id_status,
      'sort_order': instance.sort_order,
      'name': instance.name,
    };
