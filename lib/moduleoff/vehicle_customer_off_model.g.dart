// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_customer_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleCustomerOffModel _$VehicleCustomerOffModelFromJson(
    Map<String, dynamic> json) {
  return VehicleCustomerOffModel(
    json['id'] as int,
    json['id_customer'] as int,
    json['id_customer_app'] as int,
    json['id_vehicle'] as int,
    json['id_vehicle_app'] as int,
  )..id_vehicle_customer_app = json['id_vehicle_customer_app'] as int;
}

Map<String, dynamic> _$VehicleCustomerOffModelToJson(
        VehicleCustomerOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_vehicle_customer_app': instance.id_vehicle_customer_app,
      'id_customer': instance.id_customer,
      'id_customer_app': instance.id_customer_app,
      'id_vehicle': instance.id_vehicle,
      'id_vehicle_app': instance.id_vehicle_app,
    };
