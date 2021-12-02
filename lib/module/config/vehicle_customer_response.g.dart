// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleCustomerResponse _$VehicleCustomerResponseFromJson(
    Map<String, dynamic> json) {
  return VehicleCustomerResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : VehicleCustomerModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$VehicleCustomerResponseToJson(
        VehicleCustomerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
