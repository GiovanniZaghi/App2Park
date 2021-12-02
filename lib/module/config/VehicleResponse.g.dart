// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VehicleResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleResponse _$VehicleResponseFromJson(Map<String, dynamic> json) {
  return VehicleResponse(
    status: json['status'] as String,
    data: json['data'] == null
        ? null
        : Vehicle.fromJson(json['data'] as Map<String, dynamic>),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$VehicleResponseToJson(VehicleResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
