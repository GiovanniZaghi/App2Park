// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    id: json['id'] as String,
    id_customer_app: json['id_customer_app'] as String,
    cell: json['cell'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    doc: json['doc'] as String,
    id_status: json['id_status'] as String,
    date_added: json['date_added'] as String,
    date_edited: json['date_edited'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'id_customer_app': instance.id_customer_app,
      'cell': instance.cell,
      'email': instance.email,
      'name': instance.name,
      'doc': instance.doc,
      'id_status': instance.id_status,
      'date_added': instance.date_added,
      'date_edited': instance.date_edited,
    };
