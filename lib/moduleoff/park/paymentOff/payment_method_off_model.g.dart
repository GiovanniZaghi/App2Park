// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodOffModel _$PaymentMethodOffModelFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodOffModel(
    json['id'] as int,
    json['name'] as String,
    (json['flat_rate'] as num)?.toDouble(),
    (json['variable_rate'] as num)?.toDouble(),
    (json['min_value'] as num)?.toDouble(),
    json['status'] as int,
    json['sort_order'] as int,
  );
}

Map<String, dynamic> _$PaymentMethodOffModelToJson(
        PaymentMethodOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flat_rate': instance.flat_rate,
      'variable_rate': instance.variable_rate,
      'min_value': instance.min_value,
      'status': instance.status,
      'sort_order': instance.sort_order,
    };
