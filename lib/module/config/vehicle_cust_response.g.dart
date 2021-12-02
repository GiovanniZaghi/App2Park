// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_cust_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleCustResponse _$VehicleCustResponseFromJson(Map<String, dynamic> json) {
  return VehicleCustResponse(
    status: json['status'] as String,
    customers: (json['customers'] as List)
        ?.map((e) => e == null
            ? null
            : CustomersModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    vehiclecustomer: (json['vehiclecustomer'] as List)
        ?.map((e) => e == null
            ? null
            : VehicleCustomerModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$VehicleCustResponseToJson(
        VehicleCustResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'customers': instance.customers,
      'vehiclecustomer': instance.vehiclecustomer,
      'message': instance.message,
    };
