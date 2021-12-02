// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_inner_join_customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleInnerJoinCustomer _$VehicleInnerJoinCustomerFromJson(
    Map<String, dynamic> json) {
  return VehicleInnerJoinCustomer(
    json['id'] as int,
    json['id_customer_app'] as int,
    json['cell'] as String,
    json['email'] as String,
    json['name'] as String,
    json['doc'] as String,
    json['id_status'] as int,
  );
}

Map<String, dynamic> _$VehicleInnerJoinCustomerToJson(
        VehicleInnerJoinCustomer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_customer_app': instance.id_customer_app,
      'cell': instance.cell,
      'email': instance.email,
      'name': instance.name,
      'doc': instance.doc,
      'id_status': instance.id_status,
    };
