// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type_park_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeParkResponse _$VehicleTypeParkResponseFromJson(
    Map<String, dynamic> json) {
  return VehicleTypeParkResponse(
    status: json['status'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : VehicleTypeParkModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$VehicleTypeParkResponseToJson(
        VehicleTypeParkResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
