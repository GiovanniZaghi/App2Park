// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleCustomerModel _$VehicleCustomerModelFromJson(Map<String, dynamic> json) {
  return VehicleCustomerModel(
    id: json['id'] as String,
    id_vehicle_customer_app: json['id_vehicle_customer_app'] as String,
    id_customer: json['id_customer'] as String,
    id_customer_app: json['id_customer_app'] as String,
    id_vehicle: json['id_vehicle'] as String,
    id_vehicle_app: json['id_vehicle_app'] as String,
  );
}

Map<String, dynamic> _$VehicleCustomerModelToJson(
        VehicleCustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_vehicle_customer_app': instance.id_vehicle_customer_app,
      'id_customer': instance.id_customer,
      'id_customer_app': instance.id_customer_app,
      'id_vehicle': instance.id_vehicle,
      'id_vehicle_app': instance.id_vehicle_app,
    };
