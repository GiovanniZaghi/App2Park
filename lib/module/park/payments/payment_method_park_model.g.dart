// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_park_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodParkModel _$PaymentMethodParkModelFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodParkModel(
    id: json['id'] as String,
    id_park: json['id_park'] as String,
    id_payment_method: json['id_payment_method'] as String,
    flat_rate: json['flat_rate'] as String,
    variable_rate: json['variable_rate'] as String,
    min_value: json['min_value'] as String,
    status: json['status'] as String,
    sort_order: json['sort_order'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodParkModelToJson(
        PaymentMethodParkModel instance) =>
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
