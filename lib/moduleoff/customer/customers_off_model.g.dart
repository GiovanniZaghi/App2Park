// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomersOffModel _$CustomersOffModelFromJson(Map<String, dynamic> json) {
  return CustomersOffModel(
    json['id'] as int,
    json['cell'] as String,
    json['email'] as String,
    json['name'] as String,
    json['doc'] as String,
    json['id_status'] as int,
  )..id_customer_app = json['id_customer_app'] as int;
}

Map<String, dynamic> _$CustomersOffModelToJson(CustomersOffModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_customer_app': instance.id_customer_app,
      'cell': instance.cell,
      'email': instance.email,
      'name': instance.name,
      'doc': instance.doc,
      'id_status': instance.id_status,
    };
