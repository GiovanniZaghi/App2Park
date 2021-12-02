// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_park_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodParkOffModel _$PaymentMethodParkOffModelFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodParkOffModel(
    json['id'] as int,
    json['id_park'] as int,
    json['id_payment_method'] as int,
    (json['flat_rate'] as num)?.toDouble(),
    (json['variable_rate'] as num)?.toDouble(),
    (json['min_value'] as num)?.toDouble(),
    json['status'] as int,
    json['sort_order'] as int,
  );
}

Map<String, dynamic> _$PaymentMethodParkOffModelToJson(
        PaymentMethodParkOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_park': instance.id_park,
      'id_payment_method': instance.id_payment_method,
      'flat_rate': instance.flat_rate,
      'variable_rate': instance.variable_rate,
      'min_value': instance.min_value,
      'status': instance.status,
      'sort_order': instance.sort_order,
    };
