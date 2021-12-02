// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_park_check_box.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodParkCheckBox _$PaymentMethodParkCheckBoxFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodParkCheckBox(
    payment: json['payment'] as String,
    status: json['status'] as bool,
  );
}

Map<String, dynamic> _$PaymentMethodParkCheckBoxToJson(
        PaymentMethodParkCheckBox instance) =>
    <String, dynamic>{
      'payment': instance.payment,
      'status': instance.status,
    };
