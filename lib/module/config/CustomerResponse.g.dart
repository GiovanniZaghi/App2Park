// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomerResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) {
  return CustomerResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Customer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
