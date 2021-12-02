// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) {
  return PaymentMethodModel(
    id: json['id'] as String,
    name: json['name'] as String,
    flat_rate: json['flat_rate'] as String,
    variable_rate: json['variable_rate'] as String,
    min_value: json['min_value'] as String,
    status: json['status'] as String,
    sort_order: json['sort_order'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodModelToJson(PaymentMethodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flat_rate': instance.flat_rate,
      'variable_rate': instance.variable_rate,
      'min_value': instance.min_value,
      'status': instance.status,
      'sort_order': instance.sort_order,
    };
