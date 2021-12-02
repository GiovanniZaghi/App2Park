// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_park_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodParkResponse _$PaymentMethodParkResponseFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodParkResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PaymentMethodParkModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodParkResponseToJson(
        PaymentMethodParkResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
